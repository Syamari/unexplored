class CreateListArtists < ActiveRecord::Migration[7.1]
  def change
    create_table :list_artists do |t|
      t.references :list, null: false, foreign_key: true
      t.references :artist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
