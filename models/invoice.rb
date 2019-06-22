# frozen_string_literal: true

require_relative 'application_base'

class Invoice < ApplicationBase
  has_many :invoice_datas, dependent: :destroy
  belongs_to :batch

  validates :operation_number, presence: true,
                               uniqueness: true, numericality: { less_than: 1_000_000_000 }
  validates :operation_date, presence: true
  validates :company_code, presence: true, inclusion: 1_000..9_999
end
