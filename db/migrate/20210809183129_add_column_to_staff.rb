class AddColumnToStaff < ActiveRecord::Migration[6.1]
  def change
    add_column :staffs, :organization_id, :string
    add_column :staffs, :shop_id, :string
    add_column :staffs, :name, :string
    add_column :staffs, :salary, :integer
    add_column :staffs, :contact, :string
    add_column :staffs, :address, :string
    rename_column :staffs, :email, :username
  end
end
