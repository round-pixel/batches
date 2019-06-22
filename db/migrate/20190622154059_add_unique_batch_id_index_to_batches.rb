# frozen_string_literal: true

class AddUniqueBatchIdIndexToBatches < ActiveRecord::Migration[5.2]
  def change
    change_column :batches, :batch_id, :integer, unique: true
  end
end
