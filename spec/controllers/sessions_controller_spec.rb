require "rails_helper"

describe SessionsController do
  let(:user) { create(:user) }
  
  describe 'User Sign in' do

    it 'calls sign_in and redirects to their profile page' do
      expect(subject).to receive(:sign_in)

      post :create, email: user.email, password: user.password

      expect(flash[:success]).to be_present
      expect(response).to redirect_to user_profile_path(user)

      # have to reload user, sign-in regenerates auth token
      # expect(response.cookies["auth_token"]).to eq(user.auth_token)
    end


    it "does not sign with invalid email or password" do
      expect(subject).not_to receive(:sign_in)

      post :create, email: user.email, password: "invalid"
      
      expect(flash[:danger]).to be_present
      expect(response).to redirect_to signup_path

      # expect(response.cookies["auth_token"]).to be_nil
    end
  end


  describe 'User Sign Out' do
    before do
      request.cookies["auth_token"] = user.auth_token
    end

    it "returns the user to the 'signup' page" do
      delete :destroy

      expect(flash[:info]).to be_present
      expect(cookies[:auth_token]).to be_nil
      expect(response).to redirect_to signup_path
    end
  end
end