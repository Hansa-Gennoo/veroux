class CreateServices < ActiveRecord::Migration[8.1]
  def change
    create_table :services do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.integer :duration_minutes
      t.integer :price_cents
      t.string :currency
      t.integer :goal
      t.boolean :is_active, default: true, null: false

      t.timestamps
    end
  end
end
