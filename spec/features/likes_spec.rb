require "rails_helper"

feature 'Liking posts, comments, etc' do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:post) { create(:post, author: another_user) }

  before :each do
    post
    sign_in(user)
    visit user_timeline_path(another_user)
  end

  
  scenario "A User can like posts" do
    expect { click_link "Like" }.to change(Like, :count).by(1)
    expect(page).to have_content("You liked the Post!")
  end


  scenario 'A User can unlike posts' do
    click_link "Like"
    expect { click_link "Unlike" }.to change(Like, :count).by(-1)
    expect(page).to have_content("You unliked the Post!")    
  end


  scenario "A User can like comments" do
    create(:comment, author: user, commentable: post)
    visit user_timeline_path(another_user)

    expect do
      page.find(".comment").click_link('Like')
    end.to change(Like, :count).by(1)   
     
    expect(page).to have_content("You liked the Comment!")
  end


  scenario 'A User can unlike comments' do
    create(:comment, author: user, commentable: post)
    visit user_timeline_path(another_user)
    page.find(".comment").click_link('Like')

    expect do
      page.find(".comment").click_link('Unlike')
    end.to change(Like, :count).by(-1)   

    expect(page).to have_content("You unliked the Comment!")
  end  

end