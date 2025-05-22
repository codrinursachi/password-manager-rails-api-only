class AddWebauthnColumnsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :credential_id, :string
    add_column :users, :public_key, :text
    add_column :users, :sign_count, :integer
  end
end
