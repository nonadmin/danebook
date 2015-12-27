require "rails_helper"

feature "Friending a User" do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }

  scenario "User can friend another user from their timeline" do
    sign_in(user)
    visit user_timeline_path(another_user)
    expect{ click_link "Add Friend" }.to change(Friending, :count).by(2)
    expect(page).to have_content("are now friends!")
  end


  scenario "User can remove friend from their timeline" do
    sign_in(user)
    visit user_timeline_path(another_user)
    click_link "Add Friend"
    expect{ click_link "Remove Friend" }.to change(Friending, :count).by(-2)
    expect(page).to have_content("no longer friends with")
  end
end