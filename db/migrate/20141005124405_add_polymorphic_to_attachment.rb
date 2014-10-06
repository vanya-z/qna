class AddPolymorphicToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :attachmentable_id, :integer
    add_column :attachments, :attachmentable_type, :string

    add_index :attachments, :attachmentable_id
    add_index :attachments, :attachmentable_type
  end
end
