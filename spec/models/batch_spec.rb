# frozen_string_literal: true

RSpec.describe Batch, type: :model do
  describe 'associations' do
    it { should belong_to(:batch_file).class_name('BatchFile') }
  end

  describe 'validations' do
    it { should validate_presence_of(:batch_id) }
    it { should validate_uniqueness_of(:batch_id) }
  end
end
