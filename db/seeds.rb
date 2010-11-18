puts "Creating photographer"
photographer = Photographer.create(
  :name => 'GrokPhoto',
  :email => "photographer@grokphoto.org",
  :site_url => 'http://demo.grokphoto.org',
  :blog_url => 'http://rapin.com',
  :twitter_url => 'http://twitter.com/#!/rapind',
  :use_watermark => false,
  :theme => 'default',
  :google_analytics_key => 'UA-2450369-23',
  :google_verification_key => 'n4L_tj44fmy3dxPuLamOqAkrjRP7GW-ehMzRcN6mjM0'
)

puts "Uploading watermark..."
photographer.watermark = File.new(File.join(Rails.root, 'photoshop', 'watermark.png')) rescue nil
photographer.save

puts "Creating clients"
client = Client.create!(:name => 'Demo Client', :email => "client@grokphoto.org", :password => "password", :password_confirmation => "password")

puts "Creating bookings"
client.bookings.create!(:title => 'Newborn Session', :occurs_on => 3.weeks.ago, :expires_on => 1.week.ago)
client.bookings.create!(:title => 'Family Session', :occurs_on => 2.weeks.from_now, :expires_on => 4.weeks.from_now)

puts "Creating galleries"
Gallery.create!(:pos => 1, :title => 'Family', :keywords => "portfolio, professional, photography, gallery, photo, client, workflow, management, booking, ruby, rails", :description => "GrokPhoto is an open-source professional photographer gallery, client manager, booking manager, and photo system. Add as many galleries and pages as you like to your site once it's been setup.")
Gallery.create!(:pos => 2, :title => 'Newborn', :keywords => "professional, photography, gallery, photo, client, workflow, management, booking, ruby, rails", :description => "You can create bookings for your clients, upload multiple photos to a booking with one click, and then send out a custom invite message giving your client secure access.")
Gallery.create!(:pos => 3, :title => 'Babies and Children', :keywords => "themes, professional, photography, gallery, photo, client, workflow, management, booking, ruby, rails", :description => "You can create your own themes. All you need is a little HTML knowledge, or even better some Ruby on Rails experience to create more advanced themes.")
Gallery.create!(:pos => 4, :title => 'Maternity', :keywords => "opensource, professional, photography, gallery, photo, client, workflow, management, booking, ruby, rails", :description => "GrokPhoto is completely open-source. This means if you know a little bit about coding (or someone who does), you can have your own version and theme up and running within a few minutes. The engine behind GrokPhoto is Ruby on Rails.")
# Uploading gallery slides
base_dir = File.join(Rails.root, 'photoshop', 'galleries')
for gallery in Gallery.all
  file_name = "#{gallery.title.downcase.gsub(' ', '-')}.jpg"
  file_path = File.join(base_dir, file_name)
  puts "Uploading gallery slide: #{file_path}"
  begin
    gallery.slide = File.new(file_path)
    gallery.save
  rescue Exception => e
    puts e.message
  end
end
# Uploading gallery photos
base_dir = File.join(Rails.root, 'photoshop', 'galleries')
for gallery in Gallery.all
  photos_dir = File.join(base_dir, gallery.title.downcase.gsub(' ', '-'))
  file_names = Dir.glob("#{photos_dir}/*.jpg")
  file_names.each_with_index do |file_name, idx|
    puts "Uploading gallery photo: #{file_name}"
    begin
      gallery.gallery_photos.create!(:pos => (idx + 1), :photo => File.new(file_name))
    rescue Exception => e
      puts e.message
    end
  end
end

puts "Creating pages"
Page.create!(:pos => 1, :title => 'Home', :intro => "So what's it all about?", :keywords => "about, story, ruby, rails, photography, professional, custom, page management, wiki, markdown, opensource", :body => "The Story\n---------\n\nI needed to build a professional photography site for a friend along with a way for her to easily manage clients, bookings, and photos.\n\nWhile there are plenty of open source galleries out there, most are written in PHP whereas my personal preference is Ruby on Rails. Also, I was unable to find any that supported the more advanced features we needed for managing client photos and workflow.\n\nAnd so grokphoto was born.\n\nYou can access the admin area at:\n\n* [http://www.grokphoto.org/admin](http://www.grokphoto.org/admin)\n* Email: photographer@grokphoto.org\n* Password: password\n\nYou can access the client area at:\n\n* [http://www.grokphoto.org/client](http://www.grokphoto.org/client)\n* Email: client@grokphoto.org\n* Password: password")
Page.create!(:pos => 2, :title => 'About', :intro => "So what's it all about?", :keywords => "about, story, ruby, rails, photography, professional, custom, page management, wiki, markdown, opensource", :body => "The Story\n---------\n\nI needed to build a professional photography site for a friend along with a way for her to easily manage clients, bookings, and photos.\n\nWhile there are plenty of open source galleries out there, most are written in PHP whereas my personal preference is Ruby on Rails. Also, I was unable to find any that supported the more advanced features we needed for managing client photos and workflow.\n\nAnd so grokphoto was born.\n\nYou can access the admin area at:\n\n* [http://www.grokphoto.org/admin](http://www.grokphoto.org/admin)\n* Email: photographer@grokphoto.org\n* Password: password\n\nYou can access the client area at:\n\n* [http://www.grokphoto.org/client](http://www.grokphoto.org/client)\n* Email: client@grokphoto.org\n* Password: password")
Page.create!(:pos => 3, :title => 'Opensource', :intro => 'GrokPhoto is free!', :keywords => "opensource, ruby, rails, photography, git, haml, ajax, jquery, themes, erb", :body => "Get the Source\n-----------\n\n[http://github.com/rapind/grokphoto](http://github.com/rapind/grokphoto)\n\nFrom Wikipedia\n------------\n\nOpen-source software (OSS) is computer software for which the source code and certain other rights normally reserved for copyright holders are provided under a software license that meets the Open Source Definition or that is in the public domain. This permits users to use, change, and improve the software, and to redistribute it in modified or unmodified forms. It is very often developed in a public, collaborative manner. Open-source software is the most prominent example of open-source development and often compared to user-generated content. The term open-source software originated as part of a marketing campaign for free software. A report by Standish Group states that adoption of open-source software models has resulted in savings of about $60 billion per year to consumers.\n\n[http://en.wikipedia.org/wiki/Open_source_software](http://en.wikipedia.org/wiki/Open_source_software)")

# Uploading page images
base_dir = File.join(Rails.root, 'photoshop', 'pages')
for page in Page.all
  file_name = "#{page.title.downcase.gsub(' ', '-')}.png"
  file_path = File.join(base_dir, file_name)
  puts "Uploading page image: #{file_path}"
  begin
    page.image = File.new(file_path)
    page.save
  rescue Exception => e
    puts e.message
  end
end

puts "Creating testimonials"
Testimonial.create!(:pos => 1, :author => 'Dave Rapin - Toronto', :body => "If I had some testimonials, this is where they'd go!")
Testimonial.create!(:pos => 2, :author => 'Franky Tomato - Vancouver', :body => "Best photos evah!")
