# frozen_string_literal: true

require_relative 'application_base'

class Batch < ApplicationBase
  belongs_to :batch_file

  validates :batch_id, presence: true, uniqueness: true
end
