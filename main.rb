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
  @batches = Batch.all
  erb :batches
end

post '/upload' do
  tempfile = params[:file][:tempfile]
  filename = params[:file][:filename]
  FileUtils.mv(tempfile.path, "uploaders/#{filename}")
  xml = File.open("uploaders/#{filename}")
  doc = Nokogiri::XML(xml)

  ApplicationBase.transaction do
    batch_file = BatchFile.create(guid: doc.xpath('//FileAttribute//GUID').text)
    Batch.create(
      batch_id: doc.xpath('//FileData//Batch//BatchID').text,
      creation_date: doc.xpath('//FileData//Batch//CreationDate').text,
      batch_file: batch_file
    )
  end

  redirect '/'
end

post '/clear' do
  BatchFile.destroy_all

  redirect '/'
end
