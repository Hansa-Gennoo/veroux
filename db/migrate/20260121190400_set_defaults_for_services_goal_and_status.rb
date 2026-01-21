class SetDefaultsForServicesGoalAndStatus < ActiveRecord::Migration[8.1]
  def up
    # Backfill existing rows
    execute "UPDATE services SET goal = 0 WHERE goal IS NULL"
    execute "UPDATE services SET status = 0 WHERE status IS NULL"

    change_column_default :services, :goal, from: nil, to: 0
    change_column_default :services, :status, from: nil, to: 0

    change_column_null :services, :goal, false
    change_column_null :services, :status, false
  end

  def down
    change_column_null :services, :goal, true
    change_column_null :services, :status, true

    change_column_default :services, :goal, from: 0, to: nil
    change_column_default :services, :status, from: 0, to: nil
  end
end
