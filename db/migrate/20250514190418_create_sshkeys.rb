class CreateSshkeys < ActiveRecord::Migration[8.0]
  def change
    create_table :sshkeys do |t|
      t.string :name
      t.string :private_key
      t.string :iv
      t.string :public_key
      t.string :notes
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
