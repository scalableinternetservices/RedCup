class RemoveIndex < ActiveRecord::Migration[6.1]
  def change
    #remove index for load test
    remove_index :users, :email
    remove_index :users, :reset_password_token
    
    remove_index :vlogs, :user_id

    remove_index :comments, :user_id
    remove_index :comments, :vlog_id
  end
end
