require "rails_helper"

feature 'User Profile' do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }

  scenario 'User can update their profile' do
    sign_in(user)
    visit user_profile_path(user)
    click_link "Edit your Profile"
    fill_in "profile[college]", with: "Testing U"
    fill_in "profile[about]", with: "I love to test!"
    click_button "Save Changes"

    expect(page).to have_content("Profile Updated!")
    expect(page).to have_link("Edit your Profile")
  end

end