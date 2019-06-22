# frozen_string_literal: true

class AddRefBatchFileIdToBatches < ActiveRecord::Migration[5.2]
  def change
    add_reference :batches, :batch_file, foreign_key: true
  end
end
