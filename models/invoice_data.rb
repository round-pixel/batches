# frozen_string_literal: true

require_relative 'application_base'

class InvoiceData < ApplicationBase
  self.table_name = 'invoice_datas'
  belongs_to :invoice

  validates :parcel_code, presence: true, format: { with: /\d{,15}/ }
  validates :parcel_price, presence: true, numericality: { less_than: 90_001 }
  validates :item_qty, presence: true, numericality: { less_than: 51 }
end
