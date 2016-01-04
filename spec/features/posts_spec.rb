require "rails_helper"

feature 'Posting timeline updates' do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }

  scenario 'User can post to their timeline' do
    sign_in(user)
    visit user_timeline_path(user)
    fill_in "post[body]", with: "I'm here to kick ass and chew bubble gum!"

    expect{ click_button "Post" }.to change(Post, :count).by(1)
    expect(page).to have_content("Posted to Timeline!")
    expect(page).to have_content("I'm here to kick ass and chew bubble gum!")
  end


  scenario "User can't make posts that are too short" do
    sign_in(user)
    visit user_timeline_path(user)
    fill_in "post[body]", with: ":-)"

    expect{ click_button "Post" }.not_to change(Post, :count)
    expect(page).to have_content("Oops")
  end


  scenario "Users can delete their own posts" do
    sign_in(user)
    visit user_timeline_path(user)
    fill_in "post[body]", with: "Dust to dust"
    
    click_button "Post"
    expect{ click_link "Delete" }.to change(Post, :count).by(-1)
    expect(page).not_to have_content("Dust to dust")
  end  
end