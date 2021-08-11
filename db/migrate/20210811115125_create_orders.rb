class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :shop
      t.references :organization
      t.references :staff
      t.float :amount
      t.float :discount
      t.float :paid_ammount
      t.string :table_no

      t.timestamps
    end
  end
end
