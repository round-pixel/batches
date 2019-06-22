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
    batch_file = BatchFile.create!(
      guid: doc.xpath('//FileAttribute//GUID').text,
      filename: filename
    )

    batch = Batch.create!(
      batchid: doc.xpath('//FileData//Batch//BatchID').text.to_i,
      creation_date: doc.xpath('//FileData//Batch//CreationDate').text,
      batch_file: batch_file
    )

    doc.xpath('//FileData//Invoice').each do |invoice|
      _invoice = Invoice.create!(
        operation_date: invoice.xpath('.//InvoiceOperation//InvoiceOperationDate').text,
        operation_number: invoice.xpath('.//InvoiceOperation//InvoiceOperationNumber').text.to_i,
        company_code: invoice.xpath('.//InvoiceOperation//CompanyCode').text.to_i,
        batch: batch
      )
    end
  end

  redirect '/'
end

post '/clear' do
  BatchFile.destroy_all

  redirect '/'
end
