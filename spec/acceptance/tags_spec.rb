require_relative 'acceptance_helper'

feature 'Tags', %q{
  In order to be able see tags
  As an visitor
  I want be able to see tags
 } do

  scenario 'Visitor visits tags page' do
    visit tags_path
    expect(page).to have_content 'Tags'
  end
end