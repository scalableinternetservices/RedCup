class UpdateVlogs < ActiveRecord::Migration[6.1]
  def change
    add_column :vlogs, :file_uuid, :string
    add_column :vlogs, :file_type, :string
  end
end
