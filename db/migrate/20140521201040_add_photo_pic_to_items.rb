class AddPhotoPicToItems < ActiveRecord::Migration
  def change
    add_column :items, :photo_pic, :string
  end
end
