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
    expect(page).to have_content 'Successfully authenticated from Facebook account.'
  end

  scenario "New user try to sign in with vkontakte" do
    visit new_user_session_path
    expect(page).to have_link 'vkontakte'

    set_omniauth_vkontakte
    click_link 'vkontakte'
    expect(page).to have_content 'Successfully authenticated from Vkontakte account.'
  end

  scenario "New user try to sign in with twitter" do
    visit new_user_session_path
    expect(page).to have_link 'twitter'

    set_omniauth_twitter
    click_link 'twitter'
    expect(page).to have_content 'Setting email'

    fill_in 'Email', with: 'test@example.com'
    click_button 'Finish'
    expect(page).to have_content 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'

    open_email('test@example.com')
    current_email.click_link 'Confirm my account'
    expect(page).to have_content 'Successfully authenticated from Twitter account.'
  end

  scenario "New user try to sign in with github" do
    visit new_user_session_path
    expect(page).to have_link 'github'

    set_omniauth_github
    click_link 'github'
    expect(page).to have_content 'Setting email'

    fill_in 'Email', with: 'test@example.com'
    click_button 'Finish'
    expect(page).to have_content 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'

    open_email('test@example.com')
    current_email.click_link 'Confirm my account'
    expect(page).to have_content 'Successfully authenticated from Github account.'
  end
end