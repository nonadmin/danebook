require "rails_helper"
require 'support/likeable'

describe Comment do
  let(:comment) { build(:comment) }

  it_behaves_like "likeable"

  describe 'attributes' do
    it 'is valid with a commentable parent, author, and body' do
      expect(comment).to be_valid
    end
  end


  describe 'default scope' do 
    it 'orders by ascending creation date' do
      comment_one = create(:comment)
      comment_two = create(:comment)
      expect(Comment.all).to eq([comment_one, comment_two])
    end
  end
end