require "rails_helper"

feature "Uploading Photos" do
  let(:user) { create(:user) }

  before do
    sign_in(user)
  end

  scenario "Add a new photo by uploading from computer" do
    # visit user_photos_path(user)
    # click_link("Add Photo")
    visit new_photo_path
    attach_file "photo[image]", "#{Rails.root}/spec/support/test.png"
    expect { click_button("Upload Photo") }.to change(user.photos, :count).by(1)    
  end


  scenario "Add a new photo from a web address"
end


feature "Displaying Photos" do
  scenario "View a gallery of all the user's photos"
  scenario "View an individual photo at a larger size"
end


feature "Setting Profile and Cover photos" do
  scenario "Select a photo to used as the profile/avatar"
  scenario "Select a photo to be used as the cover photo"
end
