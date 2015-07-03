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

    fill_in "Name", with: users(:vic).name
    fill_in "Email", with: users(:vic).email
    fill_in "Password", with: "newpassword"
    fill_in "Password confirmation", with: "newpassword"
    click_button "Sign up"

    page.must_have_content "Welcome! You have signed up successfully."
    page.wont_have_content "There was a problem with your sign up"
  end
end

feature "As a site owner I require sign up validation restrictions" do
  scenario "Unhappy Path: Empty Name" do
  end
  scenario "Unahppy Path: Maxed Characters for Name" do
  end

  scenario "Unhappy Path: No Email" do
  end
  scenario "Unhappy Path: Maxed Characters for Email" do
  end

  scenario "Unhappy Path: No Password" do
  end

  scenario "Unhappy Path: Maxed Password" do
  end

  scenario "Unhappy Path: No Password Confirmation" do
  end

  scenario "Unhappy Path: Maxed Password Confrimation" do
  end

  scenario "Unhappy Path: Password and Password Confrimation Dont Match" do
  end

end
