require "test_helper"

feature "As a User I wish to be able to sign up" do
  scenario "Happy Path: Home Page Signup Link" do
    visit root_path
    page.must_have_content "Sign up"
    page.must_have_content "Sign in"
  end

  scenario "Happy Path: User Enters Correct Form Data" do
    visit root_path
    click_link "Sign up"
    page.must_have_content "Name"
    page.must_have_content "Email"
    page.must_have_content "Password"

    fill_in "Name", with: "New User"
    fill_in "Email", with: "newuser@example.com"
    fill_in "Password", with: "newpassword"
    fill_in "Password confirmation", with: "newpassword"
    click_button "Sign up"

    page.must_have_content "Welcome! You have signed up successfully."
    page.wont_have_content "There was a problem with your sign up"
  end
end

feature "As a site owner I require sign up validation restrictions" do
  scenario "Unhappy Path: Empty Name" do
    visit new_user_registration_path
    fill_in "Name", with: ""
    fill_in "Email", with: "newuser@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"
    page.must_have_content "Name can't be blank"
  end
  scenario "Unhappy Path: Maxed Characters for Name" do
    visit new_user_registration_path
    fill_in "Name", with: "Me" * 31
    fill_in "Email", with: "newuser@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"
    page.must_have_content "Name is too long (maximum is 30 characters)"
  end

  scenario "Unhappy Path: No Email" do
    visit new_user_registration_path
    fill_in "Name", with: "Me"
    fill_in "Email", with: ""
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"
    page.must_have_content "Email can't be blank"
  end
  scenario "Unhappy Path: Maxed Characters for Email" do
    visit new_user_registration_path
    fill_in "Name", with: "Me"
    fill_in "Email", with: "a" * 244 + "example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"
    page.must_have_content "Email is invalid"
  end

  scenario "Unhappy Path: No Password" do
    visit new_user_registration_path
    fill_in "Name", with: "Me"
    fill_in "Email", with: "me@example.com"
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"
    page.must_have_content "Password can't be blank"

  end

  scenario "Unhappy Path: Maxed Password" do
    visit new_user_registration_path
    fill_in "Name", with: "Me"
    fill_in "Email", with: "me@example.com"
    fill_in "Password", with: "a" * 129
    fill_in "Password confirmation", with: "a" * 129
    click_button "Sign up"
    page.must_have_content "Password is too long (maximum is 128 characters)"
  end

  scenario "Unhappy Path: No Password Confirmation" do
    visit new_user_registration_path
    fill_in "Name", with: "Maxed"
    fill_in "Email", with: "maxed@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: ""
    click_button "Sign up"
    page.must_have_content "Password confirmation doesn't match Password"
  end
end
