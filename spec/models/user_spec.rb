require 'rails_helper'

describe User do
  let(:user) { build(:user) }

  describe 'attributes' do
    it 'is valid with an email address, password, and valid profile' do
      expect(user).to be_valid
    end


    it 'is invalid without an email address' do
      user.email = ''

      expect(user).not_to be_valid
    end

    # shoulda matchers gem
    it 'is invalid with a duplicate email address' do
      expect(user).to validate_uniqueness_of(:email)
    end


    it 'is invalid without a profile' do
      user.profile = nil

      expect(user).not_to be_valid
    end    


    it 'impliments has_secure_password' do
      expect(user).to have_secure_password
    end
  end


  describe 'associations' do
    it 'has one profile' do
      expect(user).to have_one(:profile).dependent(:destroy)
    end


    it 'has many posts' do
      expect(user).to have_many(:posts).dependent(:destroy)
    end


    it 'has many friends' do
      expect(user).to have_many(:friends).dependent(:destroy)
    end


    it "has many photos" do
      expect(user).to have_many(:photos).dependent(:destroy)
    end
  end


  describe ".search_by_name" do
    before do
      create_list(:user, 3)
    end

    it "returns users with first or last name matching the search term" do
      results = User.search_by_name("bar")

      expect(results.size).to eq(3)
    end


    it "returns results with partial matches" do
      results = User.search_by_name("f")

      expect(results.size).to eq(3)
    end


    it "returns nil if search string is empty" do
      results = User.search_by_name(" ")

      expect(results).to be_nil
    end


    it "returns nil if there are no results" do
      results = User.search_by_name("dixie")
      
      expect(results).to be_nil
    end
  end


  describe '#newsfeed' do
    let(:user) { create(:user_with_posts) }
    let(:another_user) { create(:user_with_posts) }

    before do
      user.friends << another_user
    end


    it "returns all of the user's posts and all of their friends' posts" do
      expect(user.newsfeed).to match_array(Post.all)
    end
  end
end