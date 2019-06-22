# frozen_string_literal: true

class AddRefBatchIdToInvoices < ActiveRecord::Migration[5.2]
  def change
    add_reference :invoices, :batch, foreign_key: true
  end
end
