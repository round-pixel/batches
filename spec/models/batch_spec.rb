# frozen_string_literal: true

RSpec.describe Batch, type: :model do
  describe 'columns' do
    it { have_db_column(:batchid).of_type(:string) }
  end

  describe 'associations' do
    it { should belong_to(:batch_file).class_name('BatchFile') }
    it { should have_many(:invoices).class_name('Invoice').dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:batchid) }
    it { should validate_uniqueness_of(:batchid) }
    it { should validate_inclusion_of(:batchid).in_range(100_000..999_999) }
  end

  describe 'indexes' do
    it { should have_db_index(:batchid) }
  end
end
