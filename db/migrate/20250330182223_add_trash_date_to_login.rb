class AddTrashDateToLogin < ActiveRecord::Migration[8.0]
  def change
    add_column :logins, :trash_date, :date
  end
end
