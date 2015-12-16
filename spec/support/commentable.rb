require 'rails_helper'

shared_examples_for "commentable" do
  let(:model) { FactoryGirl.create(described_class) }
  let(:user) { create(:user) }

  describe 'associations' do
    it 'has many comments' do
      expect(model).to have_many(:comments).dependent(:destroy)
    end
  end

end