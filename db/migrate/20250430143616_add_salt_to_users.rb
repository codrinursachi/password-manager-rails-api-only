class AddSaltToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :salt, :string
  end
end
