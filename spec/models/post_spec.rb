require 'rails_helper'
require 'support/likeable'
require 'support/commentable'

describe Post do
  let(:post) { build(:post) }

  it_behaves_like "likeable"
  it_behaves_like "commentable"

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

  describe 'default scope' do 
    it 'orders by descending creation date' do
      post_one = create(:post)
      post_two = create(:post)
      expect(Post.all).to eq([post_two, post_one])
    end
  end
end