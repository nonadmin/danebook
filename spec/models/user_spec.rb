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
  end


end