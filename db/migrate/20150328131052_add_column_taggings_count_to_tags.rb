class AddColumnTaggingsCountToTags < ActiveRecord::Migration
  def change
    add_column :tags, :taggings_count, :integer, :default => 0

    Tag.reset_column_information
    Tag.all.each do |t|
      Tag.update_counters t.id, :taggings_count => t.taggings.length
    end
  end
end
