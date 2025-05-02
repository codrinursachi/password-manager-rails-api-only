class CreateRsas < ActiveRecord::Migration[8.0]
  def change
    create_table :rsas do |t|
      t.string :public_key
      t.string :private_key
      t.string :private_key_iv
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
