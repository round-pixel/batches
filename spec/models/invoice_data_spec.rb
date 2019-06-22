# frozen_string_literal: true

RSpec.describe InvoiceData, type: :model do
  describe 'columns' do
    it { have_db_column(:parcel_code).of_type(:string) }
    it { have_db_column(:parcel_price).of_type(:integer) }
    it { have_db_column(:item_qty).of_type(:integer) }
  end

  describe 'associations' do
    it { should belong_to(:invoice).class_name('Invoice') }
  end

  describe 'validations' do
    it { should validate_presence_of(:parcel_code) }
    it { should allow_value(/\d{,15}/).for(:parcel_code) }

    it { should validate_presence_of(:parcel_price) }
    it { should validate_numericality_of(:parcel_price).is_less_than(90_001) }

    it { should validate_presence_of(:item_qty) }
    it { should validate_numericality_of(:item_qty).is_less_than(51) }
  end

  describe 'indexes' do
    it { should have_db_index(:parcel_code) }
  end
end
