# frozen_string_literal: true

require 'nokogiri'
require 'net/http'

if ARGV.length != 1
  puts 'Please input domain name.'
  exit
end

# Getting input from the user
input = ARGV[0]

# Using regex to obtain domain name of the website
domain_name = input.match(/(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\.)+[a-z0-9][a-z0-9-]{0,61}[a-z0-9]/)

puts "Domain name: #{domain_name}"

# A method to validate links
def validate_links(arr, domain_name)
  valid_links = []
  arr.each do |link|
    link.rstrip!
    link += '/' unless link.end_with?('/')
    link.prepend(ARGV[0]) if link.start_with?('/')
    valid_links.push(link) if link.include?(domain_name.to_s) && link.match(/http/)
  end
  valid_links.uniq
end

# Queue to use with BFS
queue = []

# An array to keep track of the links visited
already_visited = []

queue.push(input)

while queue.size != 0

  current = queue.shift

  next if already_visited.include?(current)

  # puts "av: #{already_visited}"
  # puts "visiting : #{current}"

  already_visited.push(current)

  # Fetching the page pointed by the URL given by the user
  uri = URI(current)
  page = Net::HTTP.get(uri)

  # Parsing the page using Nokogiri module
  # This returns Nokogiri::HTML5::Document
  doc = Nokogiri::HTML5.parse(page)

  # Searching for the anchor tag in parsed document
  # Returns NodeSet
  anchor_tags = doc.search('a')

  links = []
  current_page_links = []

  # Enumerating through the Nodeset of anchor tags and collecting links
  anchor_tags.each { |node| links << (node['href']) }

  # For pages like index.html or about.html
  links.size.times do |i|
    if links[i].instance_of?(NilClass)
      links.delete(links[i])
      next
    end
    links[i] = '/' + links[i] if links[i].end_with?('.html')
  end

  current_page_links = validate_links(links, domain_name)

  if current_page_links.instance_of?(NilClass)
    puts "\n\nUnreachable links detected: #{links}\n\n"
    next
  end

  current_page_links.each do |i|
    queue.push(i)
  end
end

already_visited = already_visited.drop(1)

builder = Nokogiri::XML::Builder.new do |xml|
  xml.urlset(xmlns: input) do
    already_visited.each do |i|
      xml.url do
        xml.loc_ i
      end
    end
  end
end

puts builder.to_xml
