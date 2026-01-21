class CreateBookings < ActiveRecord::Migration[8.1]
  def change
    create_table :bookings do |t|
      t.references :service, null: false, foreign_key: true
      t.string :client_name
      t.string :client_email
      t.datetime :starts_at
      t.integer :status
      t.text :notes

      t.timestamps
    end
  end
end
