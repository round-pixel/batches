# frozen_string_literal: true

require 'sinatra'
require 'fileutils'
require 'sinatra/activerecord'

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
    invoice_data_size = doc.xpath('//FileData//Invoice//InvoiceData').size
    raise ActiveRecord::Rollback, 'InvoiceData must be greater than 1 or less than 10' if \
      (invoice_data_size < 1) || (invoice_data_size > 10)

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
      inv = Invoice.create!(
        operation_date: invoice.xpath('.//InvoiceOperation//InvoiceOperationDate').text,
        operation_number: invoice.xpath('.//InvoiceOperation//InvoiceOperationNumber').text.to_i,
        company_code: invoice.xpath('.//InvoiceOperation//CompanyCode').text.to_i,
        batch: batch
      )

      invoice.xpath('.//InvoiceData').each do |invoice_data|
        InvoiceData.create!(
          parcel_code: invoice_data.xpath('.//ParcelCode').text,
          parcel_price: invoice_data.xpath('.//ParcelPrice').text.to_i,
          item_qty: invoice_data.xpath('.//ItemQty').text.to_i,
          invoice: inv
        )
      end
    end
  rescue => e
    # TODO: flash messages
    puts e
  end

  redirect '/'
end

post '/clear' do
  BatchFile.destroy_all

  redirect '/'
end
