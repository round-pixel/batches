class BatchFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :batche_files do |t|
      t.string :guid
      t.string :filename

      t.timestamps
    end
  end
end
