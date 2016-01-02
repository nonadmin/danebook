require 'rails_helper'

describe Profile do
  let(:profile) {build(:profile)}

  describe 'attributes' do
    it 'is valid with a first and last name, and birthday' do
      expect(profile).to be_valid
    end


    it 'is invalid when the user is too young' do
      profile.birthday = 10.years.ago
      expect(profile).not_to be_valid
    end
  end


  describe 'associations' do
    it 'belongs to profile photo (avatar)' do
      expect(profile).to belong_to(:profile_photo)
    end


    it 'belongs to cover photo' do
      expect(profile).to belong_to(:cover_photo)
    end
  end


  describe '#full_name' do  
    it 'returns the first and last name, joined' do
      profile.first_name = "foo"
      profile.last_name = "bar"
      expect(profile.full_name).to eq("Foo Bar")
    end
  end


end