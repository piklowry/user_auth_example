class AddPriceToItems < ActiveRecord::Migration
  def change
    add_column :items, :price, :string
    add_column :items, :quantity, :integer
    add_column :items, :materials, :string
    add_column :items, :views, :integer
    add_column :items, :style, :string
  end
end
