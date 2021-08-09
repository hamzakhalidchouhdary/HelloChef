class AddOrganizationReferanceToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :organization_id, :string
  end
end
