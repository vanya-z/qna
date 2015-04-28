class AddAnswersCountColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :answers_count, :integer, default: 0

    User.reset_column_information
    User.all.each do |u|
      User.update_counters u.id, :answers_count => u.answers.length
    end
  end
end
