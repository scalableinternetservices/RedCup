class AddIndexToTables < ActiveRecord::Migration[6.1]
  def change
    #add index for load test
    add_index :users, :email
    add_index :users, :reset_password_token
    
    add_index :vlogs, :user_id

    add_index :comments, :user_id
    add_index :comments, :vlog_id
  end
end
