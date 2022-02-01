class AddShopLimitToOrganization < ActiveRecord::Migration[6.1]
  def change
    add_column :organizations, :shop_limit, :integer
    
  end
end
