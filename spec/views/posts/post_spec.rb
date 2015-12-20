require "rails_helper"

describe "posts/_post.html.erb" do
  context "signed out" do
    before do
      @post = create(:post)
    end

    it "does not show like or delete links or comment box" do
      render "posts/post", post: @post

      expect(rendered).to have_content("#{@post.body}")
      expect(rendered).not_to have_link("Like")
      expect(rendered).not_to have_link("Delete")
      expect(rendered).not_to have_selector(
        "textarea[name='comment[body]']"
      )
    end
  end
  

  context "signed in" do
    describe "rendering a post authored by the current user" do
      before do
        @current_user = create(:user)
        @post = create(:post, author: @current_user)
      end

      it "shows like and delete links and new comment box" do
        render "posts/post", post: @post

        expect(rendered).to have_content("#{@post.body}")
        expect(rendered).to have_link("Like")
        expect(rendered).to have_link("Delete")
        expect(rendered).to have_selector(
          "textarea[name='comment[body]']"
        )  
      end
    end


    describe "rendering a post authored by another user" do
      before do
        @current_user = create(:user)
        @post = create(:post)
      end

       it "shows like link and new comment box but not delete link" do
        render "posts/post", post: @post

        expect(rendered).to have_content("#{@post.body}")
        expect(rendered).to have_link("Like")
        expect(rendered).not_to have_link("Delete")
        expect(rendered).to have_selector(
          "textarea[name='comment[body]']"
        )           
       end
    end
  end
end