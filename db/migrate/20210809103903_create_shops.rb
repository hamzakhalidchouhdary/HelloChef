class CreateShops < ActiveRecord::Migration[6.1]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :address
      t.string :email
      t.string :currency
      t.references :organization
      t.references :created_by, null: false, foreign_key: {to_table: :users}
      t.references :updated_by, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
