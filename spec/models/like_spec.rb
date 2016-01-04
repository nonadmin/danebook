require 'rails_helper'

describe Like do
  let(:post) { create(:post) }
  let(:user) { create(:user) }
  let(:like) { build(:like, creator: user) }

  describe 'attributes' do
    it 'only allows a user to like something once' do
      like.likeable = post

      expect(like).to be_valid
    end

    it 'does not allow a user to like something more than once' do
      like.likeable = post
      like.save!
      another_like = build(:like, creator: user, likeable: post) 
      
      expect(another_like).not_to be_valid      
    end
  end
end