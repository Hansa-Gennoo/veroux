class CreateWeeklyAvailabilities < ActiveRecord::Migration[8.1]
  def change
    create_table :weekly_availabilities do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :weekday
      t.time :start_time
      t.time :end_time
      t.boolean :enabled, default: false, null: false


      t.index [ :user_id, :weekday ], unique: true
      t.timestamps
    end
  end
end
