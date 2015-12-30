require 'rails_helper'
require 'support/likeable'
require 'support/commentable'

describe Photo do
  let(:photo) { build(:photo) }

  it_behaves_like "likeable"
  it_behaves_like "commentable"

  describe 'attributes' do
    it "has_attached_file :image"
  end
end
