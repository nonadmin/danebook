require "rails_helper"

describe LikesController do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:apost) { create(:post) }
  let(:testlike) { create(:like, likeable: apost) }

  before do
    request.cookies["auth_token"] = user.auth_token 
  end

  context 'Likes on Posts' do
    describe 'POST #create' do
      it "Current user creates a like on the post" do
        expect { 
          post :create, post_id: apost.id       
        }.to change(Like, :count).by(1)

        expect(assigns(:like).creator).to eq(user)
      end


      it "Does not create a like if the parent id is invalid" do
        expect{
          post :create, post_id: "10101011234"
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end


    describe 'DELETE #destroy' do
      it "Deletes the current user's like (aka unlike)" do
        testlike.creator = user
        testlike.save!

        expect{ 
          delete :destroy, id: testlike.id 
        }.to change(Like, :count).by(-1)
      end


      it "Redirects attempts to delete another user's like" do
        testlike.creator = another_user
        testlike.save!

        expect{ 
          delete :destroy, id: testlike.id 
        }.not_to change(Like, :count)
      end
    end
  end
end