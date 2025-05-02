class AddIvToLogins < ActiveRecord::Migration[8.0]
  def change
    add_column :logins, :iv, :string
  end
end
