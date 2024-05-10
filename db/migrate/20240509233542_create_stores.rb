class CreateStores < ActiveRecord::Migration[7.1]
  def up
    create_table :stores do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :stores, :name, unique: true, name: 'store_name_idx'
  end

  def down
    drop_table :stores
  end
end
