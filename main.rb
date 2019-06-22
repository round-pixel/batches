# frozen_string_literal: true

require 'sinatra'
require 'fileutils'
require 'sinatra/activerecord'
require 'pry'

APP_ROOT = File.dirname(__FILE__)

# load all Models
Dir[File.join(APP_ROOT, 'models', '*.rb')].each { |file| require file }

set(:views, proc { File.join(APP_ROOT, 'views') })
set(:port, 3000)
set(:database_file, 'config/database.yml')

get '/' do
  erb :batches
end

post '/upload' do
  tempfile = params[:file][:tempfile]
  filename = params[:file][:filename]
  FileUtils.mv(tempfile.path, "uploaders/#{filename}")
  redirect '/'
end
