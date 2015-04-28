class AddPasswordIsSetColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_is_set, :boolean, default: true
  end
end
