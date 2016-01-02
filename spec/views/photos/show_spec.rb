require "rails_helper"

describe "photos/show.html.erb" do
  context "User is Photo author" do
    before do
      @current_user = create(:user)
      @photo = create(:photo, author: @current_user)
    end

    it "displays the photo actions div" do
      render

      expect(rendered).to have_selector(".photo-actions")
    end
  end


  context "User is Photo author's friend" do
    before do
      @current_user = create(:user)
      another_user = create(:user)
      another_user.friends << @current_user
      @photo = create(:photo, author: another_user)
    end


    it "does not display the photo actions div" do
      render

      expect(rendered).not_to have_selector(".photo-actions")          
    end    
  end
end