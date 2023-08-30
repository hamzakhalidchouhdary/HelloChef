class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :password_digest
      t.string :contact_no
      t.string :email
      t.string :home_address
      t.string :type # enterprise | individual
      t.references :created_by, null: false, foreign_key: {to_table: :users}
      t.references :updated_by, null: false, foreign_key: {to_table: :users}
      
      t.timestamps
    end
  end
end
