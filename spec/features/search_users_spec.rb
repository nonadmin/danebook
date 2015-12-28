require "rails_helper"

feature "Searching for users" do
  let(:user) { create(:user) }

  # Need to create some users with non-generic names
  # so we can search for them.
  before :all do
    names = [ {first_name: "John", last_name: "Doe"}, 
              {first_name: "John", last_name: "Smith"}, 
              {first_name: "Jane", last_name: "Doe"}, 
              {first_name: "Jane", last_name: "Smith"} ]
    names.each { |n| create(:user, profile: build(:profile, n)) }
  end

  after :all do
    User.destroy_all
  end

  scenario "users can search based on all or part of the first or last name" do
    sign_in(user)
    fill_in "search", with: "j"
    click_button("Search", visible: false)
    expect(page).to have_content("Showing 4 users")
    expect(page).to have_content("Friends", count: 4)
  end

end
