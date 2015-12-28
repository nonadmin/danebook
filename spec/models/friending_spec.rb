require 'rails_helper'

describe Friending do
  let(:friending) { build(:friending) }
  
  describe 'associations' do
    it 'belongs to a friend initiator (user who requested to be friends)' do
      expect(friending).to belong_to(:friend_initiator)
    end


    it 'belongs to a friend receiver (user receiving friend request)' do
      expect(friending).to belong_to(:friend_receiver)
    end
  end


  describe 'validations' do
    it "is valid with a friend_initiator and friend_receiver" do
      expect(friending).to be_valid
    end


    it "is invalid with a non-existant friend_initiator" do
      friending.friender_id = 1234

      expect(friending).not_to be_valid
    end


    it 'is invalid with a non-existant friend_receiver' do
      friending.friend_id = 1234

      expect(friending).not_to be_valid      
    end


    it 'is invalid with a duplicate friendship' do
      friending.save
      invalid = build(:friending, friend_initiator: friending.friend_initiator,
                                  friend_receiver: friending.friend_receiver)
      
      expect(invalid).not_to be_valid    
    end
  end


  describe 'callbacks' do
    context "two way friendship is automatically created" do
      it "triggers #complete_friending on after create" do
        expect(friending).to receive(:complete_friending)

        friending.save
      end


      it "#complete_friending creates a new, inverse friendship" do
        expect { friending.save }.to change(Friending, :count).by(2)
        expect(Friending.last.friend_initiator).to eq(friending.friend_receiver)
      end
    end


    context "both sides of friendship are destroyed if one side is destroyed" do
      before :each do
        friending.save
      end

      it "triggers #destroy_opposite on after destroy" do
        expect(friending).to receive(:destroy_opposite)
        
        friending.destroy
      end


      it "actually destroys the opposite friending" do
        expect { friending.destroy }.to change(Friending, :count).by(-2)
      end
    end
  end
end