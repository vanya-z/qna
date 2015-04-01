require_relative 'acceptance_helper'

feature 'Signing in with omni-provider', %q{
  In order to sign in
  As an new_user_session_path
  I want be able to sign in with omni-provider
 } do

  background do
    clear_emails
  end

  scenario "New user try to sign in with facebook" do
    visit new_user_session_path
    expect(page).to have_link 'facebook'

    set_omniauth_facebook
    click_link 'facebook'
    # save_and_open_page
    expect(page).to have_content 'Successfully authenticated from Facebook account.'
  end

  scenario "New user try to sign in with twitter" do
    visit new_user_session_path
    expect(page).to have_link 'twitter'

    set_omniauth_twitter
    click_link 'twitter'
    expect(page).to have_content 'Setting email'

    fill_in 'Email', with: 'test@example.com'
    click_button 'Finish'
    expect(page).to have_content 'You have to confirm your email address before continuing.'

    open_email('test@example.com')
    current_email.click_link 'Confirm my account'
    click_link 'twitter'
    expect(page).to have_content 'Successfully authenticated from Twitter account.'
  end
end