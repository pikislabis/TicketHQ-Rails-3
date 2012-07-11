source 'https://rubygems.org'

RAILS_VERSION = '3.2'

gem 'rails', RAILS_VERSION
gem 'railties',	RAILS_VERSION

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

gem 'actionmailer',         RAILS_VERSION, :require => 'action_mailer'
gem 'activerecord',         RAILS_VERSION, :require => 'active_record'

gem 'jquery-rails'

gem 'hpricot'
gem 'ruby_parser'

gem 'haml-rails'

gem 'devise', 				'~> 2.0'	
gem "mail",           '~> 2.4'
# gem 'rd_searchlogic', :require => 'searchlogic', :git => 'git://github.com/railsdog/searchlogic.git'
gem 'ransack'
# gem 'will_paginate'
# gem 'gravatar-ultimate'
gem 'gravtastic'

gem "twitter-bootstrap-rails"

gem "paperclip"

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the web server
# gem 'unicorn'

group :development do
	gem 'sqlite3'
end

group :production do
	gem 'mysql'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end