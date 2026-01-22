class ChangeUsersPlanToInteger < ActiveRecord::Migration[8.1]
  def up
    remove_column :users, :plan, :string
    add_column :users, :plan, :integer, null: false, default: 0
  end

  def down
    remove_column :users, :plan, :integer
    add_column :users, :plan, :string
  end
end
