require "test_helper"

feature "As a User, I Would Like to Sign in/Sign out" do
  scenario "Happy Path: Sing in Successfully" do
    visit new_user_session_path
    fill_in 'Email', with: users(:vic).email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    page.must_have_content "Signed in successfully."
  end

  scenario 'Unhappy Path: Incorrect Email' do
    visit new_user_session_path
    fill_in 'Email', with: ""
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    page.must_have_content 'Invalid email or password'
  end

  scenario 'Unhappy Path: Incorrect Password' do
    visit new_user_session_path
    fill_in 'Email', with: users(:vic).email
    fill_in 'Password', with: ''
    click_button 'Log in'
    page.must_have_content 'Invalid email or password'
  end
end
