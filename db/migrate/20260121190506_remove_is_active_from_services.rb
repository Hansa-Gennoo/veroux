class RemoveIsActiveFromServices < ActiveRecord::Migration[8.1]
  def change
    remove_column :services, :is_active, :boolean
  end
end
