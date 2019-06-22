# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'pg'
gem 'rake'
gem 'sinatra'
gem 'sinatra-activerecord'

group :development, :test do
  gem 'pry'
  gem 'rspec-rails', '~> 3.8'
end

group :test do
  gem 'shoulda-matchers'
end
