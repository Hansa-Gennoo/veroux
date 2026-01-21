class AddFieldsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :name, :string
    add_column :users, :plan, :string
    add_column :users, :timezone, :string
  end
end
