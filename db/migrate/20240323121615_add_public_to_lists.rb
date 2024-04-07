class AddPublicToLists < ActiveRecord::Migration[7.1]
  def change
    add_column :lists, :public, :boolean, default: false
  end
end
