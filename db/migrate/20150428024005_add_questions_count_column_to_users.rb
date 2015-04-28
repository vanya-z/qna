class AddQuestionsCountColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :questions_count, :integer, default: 0

    User.reset_column_information
    User.all.each do |u|
      User.update_counters u.id, :questions_count => u.questions.length
    end
  end
end
