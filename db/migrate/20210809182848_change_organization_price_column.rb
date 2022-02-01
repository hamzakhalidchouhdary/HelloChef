class ChangeOrganizationPriceColumn < ActiveRecord::Migration[6.1]
  def up
    change_table :organizations do |t|
      t.change :price, :float
    end
  end

  def down
    change_table :organizations do |t|
      t.change :price, :integer
    end
  end
end
