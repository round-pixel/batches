# frozen_string_literal: true

require 'sinatra'
require 'fileutils'
require 'sinatra/activerecord'

# load all Models
Dir[File.dirname(__FILE__) + 'models/*.rb'].each { |file| require file }

set(:root, File.dirname(__FILE__))
set(:views, proc { File.join(root, 'views') })
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
