class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.references :camera, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :start_date
      t.string :end_date

      t.timestamps null: false
    end
  end
end
