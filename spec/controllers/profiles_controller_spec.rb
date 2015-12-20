require "rails_helper"

describe ProfilesController do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  
  describe 'GET #show' do
    it "renders the user's profile" do
      get :show, user_id: user.id
      expect(response).to render_template :show
    end
  end


  describe 'GET #edit' do
    before do
      request.cookies["auth_token"] = user.auth_token
    end

    it "renders the edit profile form" do
      get :edit, user_id: user.id
      expect(response).to render_template :edit
    end

  end


  describe 'PATCH #update' do
    before do
      request.cookies["auth_token"] = user.auth_token
    end
    
    it "Updates the user's profile" do
      patch :update, user_id: user.id, 
                     profile: attributes_for(:profile, college: "New College")
      
      user.reload                       
      expect(user.profile.college).to eq("New College")
    end
 
  end
end