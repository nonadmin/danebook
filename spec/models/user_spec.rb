require 'rails_helper'

describe User do
  let(:user) { build(:user) }

  it 'should be valid with an email address and password' do
    expect(user).to be_valid
  end


  it 'should be invalid without an email address' do
    user.email = ''
    expect(user).not_to be_valid
  end

  # shoulda matchers gem
  it 'should be invalid with a duplicate email address' do
    expect(user).to validate_uniqueness_of(:email)
  end


  it 'impliment has_secure_password' do
    expect(user).to have_secure_password
  end


  it 'should have_one profile' do
    expect(user).to have_one(:profile).dependent(:destroy)
  end


  it 'should have_many posts' do
    expect(user).to have_many(:posts).dependent(:destroy)
  end

end