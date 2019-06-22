# frozen_string_literal: true

class CreateBatchFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :batch_files do |t|
      t.string :guid
      t.string :filename

      t.timestamps
    end
  end
end
