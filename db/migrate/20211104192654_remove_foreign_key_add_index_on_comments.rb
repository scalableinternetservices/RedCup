class RemoveForeignKeyAddIndexOnComments < ActiveRecord::Migration[6.1]
  def change
    remove_reference :comments, :user, foreign_key: true
    add_column :comments, :user_id, :integer
    add_index :comments, :user_id
  end
end
