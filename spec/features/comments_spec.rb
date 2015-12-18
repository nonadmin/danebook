require "rails_helper"

feature 'Commenting' do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }

  before :each do
    create(:post, author: user)
    create(:post, author: another_user)
    sign_in(user)
    visit user_timeline_path(user)
  end

  scenario 'User can comment on their posts' do
    fill_in "comment[body]", with: "Remember when having the first comment was a thing?"
    expect{ click_button "Comment" }.to change(Comment, :count).by(1)
    expect(page).to have_content("Commented!")
    expect(page).to have_content("said on")
  end


  scenario 'User can comment on the posts of others' do
    visit user_timeline_path(another_user)
    fill_in "comment[body]", with: "Remember when having the first comment was a thing?"
    expect{ click_button "Comment" }.to change(Comment, :count).by(1)
    expect(page).to have_content("Commented!")
    expect(page).to have_content("said on")
  end


  scenario "User can't make comments that are too short" do
    fill_in "comment[body]", with: "nay"
    expect{ click_button "Comment" }.not_to change(Comment, :count)
    expect(page).to have_content("Body is too short")
  end


  scenario "Users can delete their own comments" do
    fill_in "comment[body]", with: "Dust to dust"
    click_button "Comment"
    expect do
      page.find(".comment").click_link('Delete')
      click_link "Delete" 
    end.to change(Comment, :count).by(-1)
    expect(page).not_to have_content("Dust to dust")
  end  
end