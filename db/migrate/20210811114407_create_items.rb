class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :shop
      t.references :staff
      t.string :title
      t.text :description
      t.float :price
      t.string :currency
      t.string :icon

      t.timestamps
    end
  end
end
