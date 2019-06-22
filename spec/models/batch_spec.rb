# frozen_string_literal: true

RSpec.describe Batch, type: :model do
  describe 'associations' do
    it { should belong_to(:batch_file).class_name('BatchFile') }
  end

  describe 'validations' do
    it { should validate_presence_of(:batchid) }
    it { should validate_uniqueness_of(:batchid) }
    it { should validate_inclusion_of(:batchid).in_range(1_000_000..9_999_999) }
  end

  describe 'indexes' do
    it { should have_db_index(:batchid) }
  end
end
