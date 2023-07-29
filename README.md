# Sitemap Builder

Welcome to the Sitemap Builder repository! This project is a Ruby script that generates a sitemap for a given website by performing a breadth-first search (BFS) traversal of its web pages. The sitemap is output in XML format, conforming to the Sitemap Protocol, which is widely used by search engines to index and crawl websites efficiently.

## Requirements

Before using the Sitemap Builder, ensure you have the following prerequisites:

- Ruby (version 2.4 or higher)
- Nokogiri gem (installed via `gem install nokogiri`)

## How to Use

1. Clone the repository to your local machine:

```bash
git clone https://github.com/your-username/sitemap-builder.git
cd sitemap-builder
```

2. Run the script and provide the domain name of the website as an argument:

```bash
ruby sitemap_builder.rb example.com
```

Replace `example.com` with the domain name of the website you want to generate the sitemap for.

3. The script will perform a BFS traversal of the website and output the sitemap in XML format. The sitemap will be displayed in the console and can be saved to a file if needed.

## How it Works

The Sitemap Builder follows these steps to generate the sitemap:

1. Input Validation: The script checks if a domain name is provided as an argument. If not, it prompts the user to input one and exits.

2. BFS Traversal: The script starts with the provided domain name and performs a BFS traversal of the website. It collects all the valid links found on each page during the traversal.

3. Link Validation: The script validates each link collected during the traversal to ensure it belongs to the same domain and uses the HTTP/HTTPS protocol.

4. Sitemap Generation: After completing the traversal, the script generates an XML sitemap using the Nokogiri gem. The sitemap contains all the valid links visited during the traversal.

## Limitations

- The script only collects links from anchor tags (`<a href="...">`) present on the web pages. It does not follow other types of links, such as JavaScript-generated links or links within iframes.

- The script may not handle certain edge cases or complex websites with dynamic content as it performs a basic BFS traversal.

## Contributing

Contributions to the Sitemap Builder are welcome! If you find any bugs, have suggestions, or want to add new features, feel free to open an issue or submit a pull request.

## Credits

The Sitemap Builder is developed by [](https://github.com/abdullahxy). Special thanks to [Nokogiri](https://nokogiri.org/) for providing the powerful HTML and XML parsing library used in this project.

---

Thank you for checking out the Sitemap Builder! If you have any questions or need assistance, feel free to reach out.

Happy sitemap building! 🚀
