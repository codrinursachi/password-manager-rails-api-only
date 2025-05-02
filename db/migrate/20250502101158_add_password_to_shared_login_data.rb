class AddPasswordToSharedLoginData < ActiveRecord::Migration[8.0]
  def change
    add_column :shared_login_data, :password, :string
  end
end
