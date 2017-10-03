class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.integer :star
      t.references :room, foreign_key: true
      t.references :reservation, foreign_key: true
      t.references :guest, foreign_key: true
      t.references :host, foreign_key: true
      t.string :type

      t.timestamps
    end
  end
end
