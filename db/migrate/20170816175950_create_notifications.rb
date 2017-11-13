class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string :content
      t.integer :type_message
      t.integer :id_object
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
