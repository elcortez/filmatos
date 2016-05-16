class CreateCameras < ActiveRecord::Migration
  def change
    create_table :cameras do |t|
      t.string :brand
      t.string :category
      t.string :description
      t.references :user, index: true, foreign_key: true
      t.integer :price

      t.timestamps null: false
    end
  end
end
