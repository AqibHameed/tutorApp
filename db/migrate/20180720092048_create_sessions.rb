class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.string :stoken
      t.boolean :sign_in_status ,null: false , default: true
      t.datetime :last_requested_at
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
