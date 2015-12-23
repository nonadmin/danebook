require "rails_helper"

feature "Friending a User" do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }

  scenario "User can friend another user from their timeline" do
    sign_in(user)
    visit user_timeline_path(another_user)
    expect{ click_button "Add Friend" }.to change(Friending, :count).by(1)
    expect(page).to have_button("Remove Friend")
    expect(page).to have_content("Friend Added!")
  end


  scenario "User can remove friend from their timeline"
end