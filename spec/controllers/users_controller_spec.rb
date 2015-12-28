require "rails_helper"

describe UsersController do
  let(:user) { build(:user) }
  let(:profile) { build(:profile) }

  def user_attributes
    profile_attribs = FactoryGirl.attributes_for(:profile)
    FactoryGirl.attributes_for(:user).merge(profile_attributes: profile_attribs)
  end

  describe 'User Signup' do
    describe 'GET #new' do
      it 'renders the signup page with the new user form' do
        get :new
        expect(response).to render_template(:new)
        expect(assigns(:user)).to be_a_new(User)
      end
    end


    describe 'POST #create' do
      it "creates the user and redirects to the user's profile" do
        expect { 
          post :create, user: user_attributes 
        }.to change(User, :count).by(1)
        expect(response).to redirect_to user_profile_path(assigns(:user))
      end


      it "does not create the user and re-renders the form if missing required information" do
        expect { 
          post :create, user: {email: ""} 
        }.not_to change(User, :count)
        expect(response).to render_template :new
      end


      it "also requires profile information" do
        expect { 
          post :create, user: attributes_for(:user)
        }.not_to change(User, :count)
        expect(response).to render_template :new
      end
    end
  end


  describe 'User Search' do
    before do
      user.save
      request.cookies["auth_token"] = user.auth_token
    end    

    describe 'GET #search' do
      it "renders the search results template" do
        get :search
        puts response.body
        expect(response).to render_template(:search)
      end


      it "assigns the results variable" do
        get :search, search: "foo"
        expect(assigns(:results)).to match_array([user])
      end
    end
  end
end