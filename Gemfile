source 'http://rubygems.org'

# stack
gem 'rails', '3.0.3'

# database
gem 'mongoid', '>= 2.0.0.beta.20'
gem 'bson_ext', '>= 1.1.2'

# markup / tempaltes
gem 'rdiscount', '>= 1.6.5'
gem 'haml', '>= 3.0.24'

# authentication
gem 'devise', '>= 1.1.3'
gem 'devise_invitable', '>= 0.3.5' # https://github.com/scambra/devise_invitable

# uploads
gem 'mini_magick', '>= 3.1' # image uploads
gem 'carrierwave', '>= 0.5.0' # image uploads
gem 'fog', '>= 0.3.23' # s3 storage

# routes
gem 'inherited_resources', '>= 1.2.1'
gem 'has_scope', '>= 0.5.0'
gem 'responders', '>= 0.6.2'

# forms
gem 'simple_form', '>= 1.2.2'

# pagination
gem 'will_paginate', '>= 3.0.pre2'

# themes
gem 'themes_for_rails', '>= 0.4.1'

# organize and minify javascripts
gem 'jammit', '>= 0.5.4'

# development and testing
group :development, :test do
  # generators
  gem 'haml-rails', '>= 0.3.4'
  gem 'hpricot', '>= 0.8.3'

  # debugging
  gem 'ruby_parser', '>= 2.0.5'
  gem RUBY_VERSION >= "1.9" ? 'ruby-debug19' : 'ruby-debug'

  # testing
  #gem 'capybara', '>= 0.4.0'
  gem 'shoulda', '>= 2.11.3'
  gem 'factory_girl_rails', '= 1.1.beta1'

  # deployment
  gem 'capistrano', '>= 2.5.19'

  # faster than webrick
  gem 'mongrel', '>= 1.2.0.pre2'
end