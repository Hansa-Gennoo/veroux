class CreateAvailabilityExceptions < ActiveRecord::Migration[8.1]
  def change
    create_table :availability_exceptions do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date
      t.time :start_time
      t.time :end_time
      t.string :reason

      t.timestamps
    end
  end
end
