class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.time :check_in
      t.time :check_out
      t.integer :price
      t.references :toilet, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :user_reviewed, default: false
      t.boolean :host_reviewed, default: false

      t.timestamps
    end
  end
end
