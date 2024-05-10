class CreateModels < ActiveRecord::Migration[7.1]
  def up
    create_table :models do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :models, :name, unique: true, name: 'model_name_idx'
  end

  def down
    drop_table :models
  end
end
