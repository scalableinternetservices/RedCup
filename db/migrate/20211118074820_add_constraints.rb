class AddConstraints < ActiveRecord::Migration[6.1]
  def change
    #add index for load test
    add_index(:likes, [:user_id, :vlog_id], unique: true)
  end
end
