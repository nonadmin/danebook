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
end