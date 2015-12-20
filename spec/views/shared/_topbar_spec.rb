require "rails_helper"

describe "shared/_topbar.html.erb" do
  context "signed out" do
    it "shows the logon form" do
      render
      expect(rendered).to have_selector("input[name='password']")
    end
  end
  

  context "signed in" do
    before do
      @current_user = create(:user)
    end
    
    it "shows the user's first name with profile link" do
      render

      expect(rendered).to have_link(
        "#{@current_user.profile.first_name.capitalize}",
        href: user_profile_path(@current_user)
      )
    end
  end
end