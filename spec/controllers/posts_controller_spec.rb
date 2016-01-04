require "rails_helper"

describe PostsController do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:apost) { build(:post) }

  context 'visitor' do   
    describe 'GET #index' do
      it "renders the index template" do
        get :index, user_id: user.id

        expect(response).to render_template(:index)
      end
    end
  end


  context 'signed in user' do
    before do
      request.cookies["auth_token"] = user.auth_token
    end


    describe 'GET #index' do
      it "sets a blank post for the current user's timeline" do
        get :index, user_id: user.id

        expect(assigns(:post)).to be_a_new(Post)
      end
    end


    describe "GET #newsfeed" do
      it "renders the newfeed template" do
        get :newsfeed

        expect(response).to render_template(:newsfeed)
      end
    end


    describe 'POST #create' do
      it "creates a new post on the current user's timeline" do
        expect { 
          post :create, user_id: user.id, post: attributes_for(:post)
        }.to change(Post, :count).by(1)

        expect(response).to redirect_to newsfeed_path
      end


      it 'flashes an error if the post is invalid' do
        post :create, user_id: user.id, post: {body: "a"}

        expect(flash[:danger]).to be_present
      end    
    end


    describe 'DELETE #destroy' do
      it "removes the post from the user's timeline" do
        apost.author = user
        apost.save

        expect { 
          delete :destroy, id: apost.id
        }.to change(Post, :count).by(-1)        
      end


      it "does not allow a user to delete another user's post" do
        apost.author = another_user
        apost.save

        expect { 
          delete :destroy, id: apost.id
        }.not_to change(Post, :count)
      end
    end

  end
end