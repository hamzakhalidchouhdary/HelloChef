class AddLabelsColToItem < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :labels, :string
  end
end
