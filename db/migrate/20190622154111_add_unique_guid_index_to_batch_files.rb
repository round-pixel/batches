# frozen_string_literal: true

class AddUniqueGuidIndexToBatchFiles < ActiveRecord::Migration[5.2]
  def change
    change_column :batch_files, :guid, :string, unique: true
  end
end
