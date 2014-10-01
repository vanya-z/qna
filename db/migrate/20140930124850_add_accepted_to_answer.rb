class AddAcceptedToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :is_accepted, :boolean, default: false
  end
end
