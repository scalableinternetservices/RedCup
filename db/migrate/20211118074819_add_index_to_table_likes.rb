class AddIndexToTableLikes < ActiveRecord::Migration[6.1]
  def change
    #add index for load test
    add_index :likes, :user_id
    add_index :likes, :vlog_id
  end
end
