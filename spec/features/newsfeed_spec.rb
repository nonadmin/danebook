require "rails_helper"

feature "Newsfeed, User Homepage" do
  let(:user) { create(:user_with_posts) }
  let(:another_user) { create(:user_with_posts) }

  before do
    sign_in(user)
    user.friends << another_user  
  end

  feature "Main Content" do
    scenario "Feed of the user's and user's friend's posts" do
      visit newsfeed_path

      expect(page).to have_link("Like", count: 10)
      expect(page).to have_content(user.posts.sample.body)
      expect(page).to have_content(another_user.posts.sample.body)
    end
  end
end