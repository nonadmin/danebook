require 'rails_helper'
require 'support/likeable'

describe Post do
  let(:post) { build(:post) }

  it_behaves_like "likeable"

  describe 'attributes' do
    it 'is valid with an author and a body' do
      expect(post).to be_valid    
    end

    it 'is invalid without an author' do
      post.user_id = 101010
      expect(post).not_to be_valid
    end

    it 'is invalid with too short of a body' do
      post.body = "a"
      expect(post).not_to be_valid
    end
  end
end