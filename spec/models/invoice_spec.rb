# frozen_string_literal: true

RSpec.describe Invoice, type: :model do
  describe 'columns' do
    it { have_db_column(:operation_number).of_type(:integer) }
    it { have_db_column(:operation_date).of_type(:integer) }
    it { have_db_column(:company_code).of_type(:integer) }
  end

  describe 'associations' do
    it { should belong_to(:batch).class_name('Batch') }
  end

  describe 'validations' do
    it { should validate_presence_of(:operation_number) }
    it { should validate_uniqueness_of(:operation_number) }
    it { should validate_numericality_of(:operation_number).is_less_than(1_000_000_000) }

    it { should validate_presence_of(:operation_date) }

    it { should validate_presence_of(:company_code) }
    it { should validate_presence_of(:company_code) }
    it { should validate_inclusion_of(:company_code).in_range(1_000..9_999) }
  end

  describe 'indexes' do
    it { should have_db_index(:operation_number) }
  end
end
