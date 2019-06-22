# frozen_string_literal: true

RSpec.describe BatchFile, type: :model do
  describe 'associations' do
    it { should have_one(:batch).class_name('Batch') }
  end

  describe 'validations' do
    it { should validate_presence_of(:guid) }
    it { should validate_uniqueness_of(:guid) }
  end

  describe 'indexes' do
    it { should have_db_index(:guid) }
  end
end
