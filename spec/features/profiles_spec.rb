require "rails_helper"

feature 'User Profile' do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }

  scenario 'User can update their profile, email is required, pre-filled' do
    sign_in(user)
    visit user_profile_path(user)
    click_link "Edit your Profile"
    fill_in "user[profile_attributes][college]", with: "Testing U"
    fill_in "user[profile_attributes][about]", with: "I love to test!"
    click_button "Save Changes"
    expect(page).to have_content("Profile Updated!")
    expect(page).to have_link("Edit your Profile")
  end


  scenario 'User can\'t remove email from their profile' do
    sign_in(user)
    visit user_profile_path(user)
    click_link "Edit your Profile"
    fill_in "user[email]", with: ""
    click_button "Save Changes"
    expect(page).to have_content("Oops, something went wrong!")
    expect(page).to have_content("Email can't be blank") 
  end
end