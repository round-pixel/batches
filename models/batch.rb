# frozen_string_literal: true

require_relative 'application_base'

class Batch < ApplicationBase
  has_many :invoices, dependent: :destroy
  belongs_to :batch_file

  validates :batchid, presence: true, uniqueness: true, inclusion: 100_000..999_999
end
