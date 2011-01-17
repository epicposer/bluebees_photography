xml.instruct!

xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  
  # Home Page
  xml.url do
    xml.loc         root_url
    xml.lastmod     w3c_date(Time.now)
    xml.changefreq  "always"
  end
  
end