class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.references :user, index: true
      t.string :provider
      t.string :uid
      t.string :confirmation_token
      t.datetime :confirmation_token_sent_at
      t.datetime :confirmed_at

      t.timestamps
    end

    add_index :authorizations, [:provider, :uid]
  end
end
