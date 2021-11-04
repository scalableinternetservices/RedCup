class UpdateForeignKeyAddOnDeleteConstraint < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :comments, :vlogs
    remove_foreign_key :comments, :users
    add_foreign_key :comments, :users, on_delete: :cascade
    add_foreign_key :comments, :vlogs, on_delete: :cascade
  end
end
