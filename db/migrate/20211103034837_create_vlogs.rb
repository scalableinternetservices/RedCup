class CreateVlogs < ActiveRecord::Migration[6.1]
  def change
    create_table :vlogs do |t|
      t.string :title
      t.text :content
      t.string :user_name

      t.timestamps
    end
  end
end
