class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :shop
      t.references :created_by, null: false, foreign_key: {to_table: :users}
      t.references :updated_by, null: false, foreign_key: {to_table: :users}
      t.float :amount
      t.float :discount
      t.float :paid_ammount
      t.string :table_no

      t.timestamps
    end
  end
end
