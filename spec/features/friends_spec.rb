require "rails_helper"

feature "Friending a User" do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }

  scenario "User can friend another user from that user's timeline" do
    sign_in(user)
    visit user_timeline_path(another_user)
    expect{ click_link "Add Friend" }.to change(Friending, :count).by(2)
    expect(page).to have_content("are now friends!")
    expect(page).to have_link("Remove Friend")
  end


  scenario "User can remove friend from that friend's timeline" do
    user.friends << another_user
    sign_in(user)
    visit user_timeline_path(another_user)
    expect{ click_link "Remove Friend" }.to change(Friending, :count).by(-2)
    expect(page).to have_content("no longer friends with")
    expect(page).to have_link("Add Friend")
  end
end


feature "Display Friends" do
  let(:user) { create(:user_with_friends) }

  scenario "Friends index for a user displays all that user's friends" do
    sign_in(user)
    friend = user.friends.sample
    visit user_friends_path(user)
    expect(page).to have_content("#{friend.profile.full_name}")
  end


  scenario "Friends panel on the timeline display random selection of friends" do
    sign_in(user)
    visit user_timeline_path(user)

    within("#friends_widget") do
      expect(page).to have_selector(".thumbnail", count: user.friends.count)
    end
  end
end