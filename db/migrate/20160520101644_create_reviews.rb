class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :content
      t.integer :rating
      t.references :camera, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
