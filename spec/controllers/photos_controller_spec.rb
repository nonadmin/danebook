require 'rails_helper'

describe PhotosController do
  let(:user) { create(:user) }
  let(:photo) { create(:photo) }

  context "visitor" do
    describe "GET #show"
    describe "GET #index"
  end


  context "signed-in user" do
    before do
      request.cookies["auth_token"] = user.auth_token
    end
    
    describe "GET #new" do
      it "renders the new photo upload form" do
        get :new

        expect(response).to render_template(:new)
      end


      it "sets a new photo object for the current user" do
        get :new

        expect(assigns(:photo)).to be_a_new(Photo)
        expect(assigns(:photo).author).to eq(user)
      end
    end

  end
end
