class AddForeignKeyAddIndexOnLikes < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :likes, :users, on_delete: :cascade
    add_foreign_key :likes, :vlogs, on_delete: :cascade
  end
end
