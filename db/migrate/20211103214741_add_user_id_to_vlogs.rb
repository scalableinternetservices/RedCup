class AddUserIdToVlogs < ActiveRecord::Migration[6.1]
  def change
    add_column :vlogs, :user_id, :integer
    add_index :vlogs, :user_id
  end
end
