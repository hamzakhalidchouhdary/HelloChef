class CreateOrganizations < ActiveRecord::Migration[6.1]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :account_type
      t.string :address
      t.string :status # active | supended
      t.integer :price
      t.string :price_type # fixed | percentage

      t.timestamps
    end
  end
end
