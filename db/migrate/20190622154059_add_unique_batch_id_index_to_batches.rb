# frozen_string_literal: true

class AddUniqueBatchIdIndexToBatches < ActiveRecord::Migration[5.2]
  def change
    change_column :batches, :batchid, :integer, unique: true
    add_index :batches, :batchid
  end
end
