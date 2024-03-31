class CreateRates < ActiveRecord::Migration[7.1]
  def change
    create_table :rates do |t|
      t.integer :score
      t.references :song, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
