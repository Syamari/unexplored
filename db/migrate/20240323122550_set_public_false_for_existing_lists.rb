class SetPublicFalseForExistingLists < ActiveRecord::Migration[7.1]
  def up
    List.update_all(public: false)
  end

  def down
  end
end
