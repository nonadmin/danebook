require 'rails_helper'

describe FriendsController do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }

  context "visitor" do
    describe 'GET #index' do
      it "renders the index template" do
        get :index, user_id: user.id

        expect(response).to render_template(:index)
      end
    end
  end


  context "signed in user" do
    before do
      request.cookies["auth_token"] = user.auth_token
    end

    describe "POST #create" do
      it "creates a new friendship for the current user" do
        expect { 

          post :create, id: another_user.id 

        }.to change(Friending, :count).by(2)
      end


      it "flashes an error if the new friendship is invalid" do
        post :create, id: 1234
        
        expect(flash[:danger]).to be_present
      end
    end


    describe "DELETE #destroy" do
      it "removes the current user's friending" do
        create(:friending, friend_initiator: user, 
                           friend_receiver: another_user)
        
        expect { 

          delete :destroy, id: another_user.id 

        }.to change(Friending, :count).by(-2)        
      end


      it "does not allow users to remove other user's friendships" do
        friending = create(:friending, friend_initiator: another_user)
        
        expect { 

          delete :destroy, id: friending.friend_id 

        }.not_to change(Friending, :count)

        expect(flash[:danger]).to be_present
      end
    end

  end
end