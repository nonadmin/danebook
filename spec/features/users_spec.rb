require "rails_helper"

feature 'User accounts' do
  scenario "Sign up with required information" do
    visit root_path
    fill_in "user[profile_attributes][first_name]", with: "foo"
    fill_in "user[profile_attributes][last_name]", with: "bar"
    fill_in "user[email]", with: "foo@example.com"
    fill_in "user[password]", with: "fooBAR01"
    fill_in "user[password_confirmation]", with: "fooBAR01"
    select("January", from: "user[profile_attributes][birthday(2i)]")
    select("1", from: "user[profile_attributes][birthday(3i)]")
    select("1982", from: "user[profile_attributes][birthday(1i)]")
    choose("user_profile_attributes_gender_female")
    expect{ click_button "Sign Up!" }.to change(User, :count).by(1)
    expect(page).to have_content("Welcome to Danebook, Foo")
    expect(page).to have_content("Words to Live By")
  end


  scenario 'Sign up with some required information missing' do
    visit root_path
    fill_in "user[profile_attributes][first_name]", with: "foo"
    fill_in "user[profile_attributes][last_name]", with: "bar"
    fill_in "user[email]", with: "foo@example.com"
    expect{ click_button "Sign Up!" }.not_to change(User, :count)
    expect(page).to have_content("something went wrong")
    expect(page).to have_content("can't be blank")
  end
end

feature "User sign-in" do
  let(:user) { create(:user, email: "foo@example.com") }
  let(:another_user) { create(:user) }

  scenario 'Sign in with valid information' do
    visit root_path
    fill_in "email", with: user.email
    fill_in "password", with: "fooBAR01"
    click_button "Logon"
    expect(page).to have_content("Welcome back, #{user.profile.first_name.capitalize}")
    expect(page).to have_content("Words to Live By")
  end

  scenario 'Sign in with invalid information' do
    visit root_path
    fill_in "email", with: "invalid@example.com"
    fill_in "password", with: "badpass"
    click_button "Logon"
    expect(page).to have_content("We couldn't sign you in!")
  end


  scenario 'Successful sign in returns user to current page' do
    visit user_timeline_path(another_user)
    fill_in "email", with: user.email
    fill_in "password", with: "fooBAR01"
    click_button "Logon"
    expect(page).to have_content("Welcome back, #{user.profile.first_name.capitalize}")
    expect(page).to have_content("#{another_user.profile.full_name}")
  end
end