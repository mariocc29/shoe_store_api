class CreateInventories < ActiveRecord::Migration[7.1]
  def up
    create_table :inventories do |t|
      t.references :store, null: false, foreign_key: true
      t.references :model, null: false, foreign_key: true
      t.integer :inventory

      t.timestamps
    end
  end

  def down
    drop_table :inventories
  end
end
