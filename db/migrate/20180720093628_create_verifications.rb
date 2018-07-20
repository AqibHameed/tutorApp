class CreateVerifications < ActiveRecord::Migration[5.2]
  def change
    create_table :verifications do |t|
      t.integer :verification_type , null: false
      t.integer :verification_status , null:false ,default: 0
      t.string  :verification_pin , null:false
      t.boolean :validity
      t.references :user, foreign_key: true
      t.timestamps
    end
    add_index :verifications, :verification_type
    add_index :verifications, :verification_status
  end
end
