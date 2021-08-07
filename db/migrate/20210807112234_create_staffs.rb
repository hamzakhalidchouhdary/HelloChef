class CreateStaffs < ActiveRecord::Migration[6.1]
  def change
    create_table :staffs do |t|
      t.string :email
      t.string :password_digest
      t.string :role
      
      t.timestamps
    end
  end
end
