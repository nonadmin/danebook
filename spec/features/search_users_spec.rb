require "rails_helper"

feature "Searching for users" do
  let(:user) { create(:user) }

  before do
    create_list(:user, 3)
    sign_in(user)
  end

  scenario "returns matches on all or part of the first or last name" do
    fill_in "search", with: "f"
    click_button("Search", visible: false)

    expect(page).to have_content("Showing 4 users")
    expect(page).to have_link("Friend Me!", count: 3)
  end


  scenario "a message is displayed if there are no results" do
    fill_in "search", with: "dixie"
    click_button("Search", visible: false)

    expect(page).to have_content("No user's names contain")    
  end

end
