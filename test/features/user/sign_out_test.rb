require "test_helper"

feature "As a User I Want to be Able to Log Out" do
  scenario "Happy Path: User Signs out" do
    visit new_user_session_path
    fill_in 'Email', with: users(:vic).email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    save_and_open_page
    click_link 'Logout'
    page.must_have_content "Signed out successfully"
  end
end
