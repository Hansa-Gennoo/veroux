class AddStatusToServices < ActiveRecord::Migration[8.1]
  def change
    add_column :services, :status, :integer, default: 0, null: false
  end
end
