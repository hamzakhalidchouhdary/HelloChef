class CreatePricings < ActiveRecord::Migration[6.1]
  def change
    create_table :pricings do |t|
      t.string :currency
      t.string :price_type
      t.float :price
      t.references :organization

      t.timestamps
    end
  end
end
