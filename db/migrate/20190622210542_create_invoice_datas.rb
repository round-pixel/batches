# frozen_string_literal: true

class CreateInvoiceDatas < ActiveRecord::Migration[5.2]
  def change
    create_table :invoice_datas do |t|
      t.string :parcel_code
      t.integer :parcel_price
      t.integer :item_qty

      t.timestamps
    end

    add_index :invoice_datas, :parcel_code
    add_reference :invoice_datas, :invoice, foreign_key: true
  end
end
