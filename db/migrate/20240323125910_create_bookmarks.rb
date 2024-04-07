class CreateBookmarks < ActiveRecord::Migration[7.1]
  def change
    create_table :bookmarks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :list, null: false, foreign_key: true

      t.timestamps
    end

    add_index :bookmarks, [:user_id, :list_id], unique: true
  end
end
