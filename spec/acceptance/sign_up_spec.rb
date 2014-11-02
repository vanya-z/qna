require_relative 'acceptance_helper'

feature 'Signing up', %q{
  In order to be able ask questions
  As an user
  I want be able to sign up
 } do

  background do
    clear_emails
    visit new_user_registration_path
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_button 'Sign up'
    expect(page).to have_content 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'
  end

  scenario 'User tries to sign up, confirm email and sign in' do    
    open_email('test@example.com')
    current_email.click_link 'Confirm my account'
    expect(page).to have_content 'Your email address has been successfully confirmed.'

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: '12345678'
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'User tries to sign up and sign in without confirmation of email' do
    visit new_user_session_path
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: '12345678'
    click_button 'Log in'
    expect(page).to have_content 'You have to confirm your email address before continuing.'
  end
end