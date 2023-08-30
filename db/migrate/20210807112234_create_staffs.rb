class CreateStaffs < ActiveRecord::Migration[6.1]
  def change
    create_table :staffs do |t|
      t.references :shop
      t.string :role
      t.float :salary
      t.references :created_by, null: false, foreign_key: {to_table: :users}
      t.references :updated_by, null: false, foreign_key: {to_table: :users}
      
      t.timestamps
    end
  end
end
