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

gem "nested_form"

gem 'ransack'
gem 'gravtastic'

gem "twitter-bootstrap-rails"

gem "paperclip"

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development do
	gem 'sqlite3'
end

group :production do
	gem 'ruby-mysql'
	#gem 'mysql'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end