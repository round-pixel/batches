# frozen_string_literal: true

class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.integer :operation_number
      t.integer :operation_date
      t.integer :company_code

      t.timestamps
    end

    add_index :invoices, :operation_number
  end
end
