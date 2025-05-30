class AddNameToNotes < ActiveRecord::Migration[8.0]
  def change
    add_column :notes, :name, :string
    add_column :notes, :name_iv, :string
  end
end
