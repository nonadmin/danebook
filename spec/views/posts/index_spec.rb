require "rails_helper"

describe "posts/index.html.erb" do
  context "signed out" do
    it "does not show the new timeline post textarea" do
      @user = create(:user)
      render

      expect(rendered).not_to have_selector(
        "text[name='post[body]']"
      )
    end
  end
  

  context "signed in" do
    describe "on the current user's timeline" do
      before do
        @current_user = create(:user_with_posts)
        @user = @current_user
        @post = build(:post, author: @current_user)
      end

      it "shows the new timeline post textarea" do
        render

        expect(rendered).to have_selector(
          "textarea[name='post[body]']"
        )
      end
    end


    describe "on another user's timeline" do
      before do
        @current_user = create(:user_with_posts)
        @user = create(:user)
      end

       it "does not show the new timeline post textarea" do
        render

        expect(rendered).not_to have_selector(
          "text[name='post[body]']"
        )
      end   
    end
  end
end