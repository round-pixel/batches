# frozen_string_literal: true

require 'nokogiri'

class ApplicationBase < ActiveRecord::Base
  self.abstract_class = true
end
