# frozen_string_literal: true

require_relative 'application_base'

class Batch < ApplicationBase
  has_many :invoices, dependent: :destroy
  belongs_to :batch_file

  validates :batchid, presence: true, uniqueness: true, inclusion: 1_000_000..9_999_999
end
