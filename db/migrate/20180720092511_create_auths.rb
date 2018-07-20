class CreateAuths < ActiveRecord::Migration[5.2]
  def change
    create_table :auths do |t|
      t.integer :status,null: false , default: 0
      t.string :password_digest, null: false
      t.boolean :email_verified
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
