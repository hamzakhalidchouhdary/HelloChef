class CreateOrganizations < ActiveRecord::Migration[6.1]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :account_type
      t.string :address
      t.string :status # active | supended
      t.string :contact_no
      t.string :email
      t.integer :shop_limit
      t.string :price_type
      t.float :price
      t.references :created_by, null: false, foreign_key: {to_table: :users}
      t.references :updated_by, null: false, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
