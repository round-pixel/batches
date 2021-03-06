# frozen_string_literal: true

require_relative 'application_base'

class BatchFile < ApplicationBase
  has_one :batch, dependent: :destroy

  validates :guid, presence: true, uniqueness: true
end
