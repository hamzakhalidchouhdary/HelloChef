class CreateBills < ActiveRecord::Migration[6.1]
  def change
    create_table :bills do |t|
      t.float :amount
      t.string :month
      t.boolean :is_paid
      t.float :discount
      t.references :organization

      t.timestamps
    end
  end
end
