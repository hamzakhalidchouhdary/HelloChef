class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :shop
      t.references :created_by, null: false, foreign_key: {to_table: :users}
      t.references :updated_by, null: false, foreign_key: {to_table: :users}
      t.string :title
      t.text :description
      t.float :price
      t.string :icon

      t.timestamps
    end
  end
end
