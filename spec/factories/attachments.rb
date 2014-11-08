# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attachment do
    file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'Gemfile')) }
    attachmentable_id 1
    attachmentable_type "MyAttachmentable"
  end
end
