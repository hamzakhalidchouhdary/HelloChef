class CreateStaffs < ActiveRecord::Migration[6.1]
  def change
    create_table :staffs do |t|
      t.string :username
      t.string :password_digest
      t.string :role
      t.string :organization_id
      t.string :shop_id
      t.string :name
      t.integer :salary
      t.string :contact
      t.string :address
      
      t.timestamps
    end
  end
end
