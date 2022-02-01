class AddColumnToOrganization < ActiveRecord::Migration[6.1]
  def change
    add_column :organizations, :contact_no, :string
    add_column :organizations, :email, :string
  end
end
