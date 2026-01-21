class AddProfileToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :slug, :string
    add_column :users, :display_name, :string
    add_column :users, :bio, :text
    add_index :users, :slug, unique: true
  end
end
