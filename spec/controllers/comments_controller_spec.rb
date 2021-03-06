require "rails_helper"

describe CommentsController do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:apost) { create(:post) }
  let(:aphoto) { create(:photo) }
  let(:acomment) { build(:comment) }

  before do
    request.cookies["auth_token"] = user.auth_token 
  end

  context 'Comments on Posts' do
    describe 'POST #create' do
      it "Creates a comment authored by the current user" do
        expect { 
          post :create, post_id: apost.id, comment: attributes_for(:comment)       
        }.to change(Comment, :count).by(1)

        expect(assigns(:comment).author).to eq(user)
      end

      
      it "renders an error if the comment is invalid" do
        post :create, post_id: apost.id, comment: {body: "a"}

        expect(flash[:danger]).to be_present
      end
    end


    describe 'DELETE #destroy' do
      it "Deletes the current user's comment" do
        acomment.author = user
        acomment.commentable = apost
        acomment.save!

        expect{ 
          delete :destroy, id: acomment.id 
        }.to change(Comment, :count).by(-1)
      end


      it "Redirects attempts to delete another user's comments" do
        acomment.author = another_user
        acomment.commentable = apost
        acomment.save!        

        expect{ 
          delete :destroy, id: acomment.id
        }.not_to change(Comment, :count)
      end
    end
  end


  context 'Comments on Photos' do
    describe 'POST #create' do
      it "Creates a comment authored by the current user" do
        expect { 
          post :create, photo_id: aphoto.id, comment: attributes_for(:comment)       
        }.to change(Comment, :count).by(1)

        expect(assigns(:comment).author).to eq(user)
      end
      it "renders parent with error if body is too short" do
        post :create, photo_id: aphoto.id, comment: {body: "a"}

        expect(flash[:danger]).to be_present
      end
    end


    describe 'DELETE #destroy' do
      it "Deletes the current user's comment" do
        acomment.author = user
        acomment.commentable = aphoto
        acomment.save!

        expect{ 
          delete :destroy, id: acomment.id 
        }.to change(Comment, :count).by(-1)
      end


      it "Redirects attempts to delete another user's comments" do
        acomment.author = another_user
        acomment.commentable = aphoto
        acomment.save!        

        expect{ 
          delete :destroy, id: acomment.id
        }.not_to change(Comment, :count)
      end
    end
  end  
end