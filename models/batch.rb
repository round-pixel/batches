# frozen_string_literal: true

require_relative 'application_base'

class Batch < ApplicationBase
  belongs_to :batch_file

  validates :batchid, presence: true, uniqueness: true
end
