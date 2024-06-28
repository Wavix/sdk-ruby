# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in wavix-sdk-ruby.gemspec
gemspec

gem 'faraday', '>= 0.17.6'
gem 'json-schema', '~> 2.8.1'
gem 'rspec', '3.13.0', require: false

group :test, :development do
  gem 'byebug', '11.1.3'
end

group :rubocop do
  gem 'rubocop', '1.60.2', require: false
  gem 'rubocop-factory_bot', '2.22.0', require: false
  gem 'rubocop-packaging', '0.5.2', require: false
  gem 'rubocop-rspec', '2.26.1', require: false
end

group :test do
  gem 'webmock'
end
