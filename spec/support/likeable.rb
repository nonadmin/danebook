require 'rails_helper'

shared_examples_for "likeable" do
  let(:model) { FactoryGirl.create(described_class) }
  let(:user) { create(:user) }

  describe 'associations' do
    it 'has many likes' do
      expect(model).to have_many(:likes).dependent(:destroy)
    end


    it 'has many likers' do
      expect(model).to have_many(:likers)
    end
  end

  describe '#like_id_for(current_user)' do
    it 'returns the like id for the current_user\'s like' do
      like = model.likes.new(creator: user)
      model.save!
      expect(model.like_id_for(user)).to eq(like.id)
    end

    it "returns nil if the current_user has not liked the #{described_class}" do
      another_user = create(:user)
      model.likes.new(creator: another_user)
      model.save!
      expect(model.like_id_for(user)).to be_nil
    end
  end

end