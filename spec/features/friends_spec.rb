require "rails_helper"

feature "Friending and Unfriending" do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }

  before do
    sign_in(user)  
  end

  scenario "User can friend another user from that user's timeline" do
    visit user_timeline_path(another_user)

    expect{ click_link "Add Friend" }.to change(Friending, :count).by(2)
    expect(page).to have_content("are now friends!")
    expect(page).to have_link("Remove Friend")
  end


  scenario "User can remove friend from that friend's timeline" do
    user.friends << another_user
    visit user_timeline_path(another_user)

    expect{ click_link "Remove Friend" }.to change(Friending, :count).by(-2)
    expect(page).to have_content("no longer friends with")
    expect(page).to have_link("Add Friend")
  end
end


feature "Display Friends" do
  let(:user) { create(:user_with_friends) }
  let(:another_user) { create(:user) }

  feature "User's Friends Page/Index" do
    scenario "Displays all that user's friends" do
      friend = user.friends.sample
      visit user_friends_path(user)

      expect(page).to have_content("#{friend.profile.full_name}")
    end


    scenario "A sad message is shown if the user has no friends" do
      visit user_friends_path(another_user)
      
      expect(page).to have_content("No friends :(")
    end
  end


  feature "Timeline Friend's Panel" do
    scenario "Display random selection of friends" do
      visit user_timeline_path(user)

      within("#friends-widget") do
        expect(page).to have_selector(".thumbnail", count: user.friends.count)
      end
    end


    scenario "Does not appear if the user has no friends" do
      visit user_timeline_path(another_user)

      expect(page).not_to have_selector("#friends-widget")
    end
  end
end