require 'sinatra'
require 'fileutils'

set :root, File.dirname(__FILE__)
set :views, Proc.new { File.join(root, 'views') }
set :port, 3000

get '/' do
  erb :batches
end

post '/upload' do
  tempfile = params[:file][:tempfile]
  filename = params[:file][:filename]
  FileUtils.cp(tempfile.path, "uploaders/#{filename}")
  redirect '/'
end
