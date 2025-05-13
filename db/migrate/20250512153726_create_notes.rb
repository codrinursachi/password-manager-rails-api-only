class CreateNotes < ActiveRecord::Migration[8.0]
  def change
    create_table :notes do |t|
      t.string :text
      t.string :iv
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
