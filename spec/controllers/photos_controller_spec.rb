require 'rails_helper'

describe PhotosController do
  let(:user) { create(:user) }
  let(:photo) { create(:photo, author: user) }
  let(:another_photo) { create(:photo) }

  context "visitor" do
    describe "GET #index" do
      it "renders the photo index template" do
        get :index, user_id: user.id

        expect(response).to render_template(:index)
      end
    end
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


    describe "POST #create" do
      let(:photo_url) do
        ActionController::Base.new.view_context.
          asset_url("icon_photo_small.png", host: "http://localhost:3000")
      end

      let(:photo_upload) do
        photo_path = "#{Rails.root}/spec/support/test.png"
        Rack::Test::UploadedFile.new(photo_path,'image/png')
      end

      it "uploads a photo from the current user's computer" do
        expect { 
        
          post :create, photo: {image: photo_upload}
        
        }.to change(user.photos, :count).by(1)
      end

      it "uploads a photo from a web url" do
        expect { 
        
          post :create, photo: {url: photo_url}
        
        }.to change(user.photos, :count).by(1)
      end
      

      it "redirects to the photo's show page" do
        post :create, photo: {image: photo_upload}

        expect(response).to redirect_to Photo.last  
      end


      it "re-renders the new photo form on error" do
        post :create, photo: {image: nil}

        expect(response).to render_template(:new)
        expect(assigns(:photo).errors).to be_present
      end
    end


    describe "GET #show" do
      it "renders the show template" do
        get :show, id: photo.id

        expect(response).to render_template :show
      end

      context 'restricted' do
        it "redirects if user isn't photo author or a friend of author" do
          get :show, id: another_photo.id

          expect(response).to redirect_to root_path
          expect(flash[:danger]).to be_present
        end


        it "renders show if the user is a friend" do
          another_photo.author.friends << user
          get :show, id: another_photo.id

          expect(response).to render_template :show         
        end
      end
    end


    describe "POST #change_user_photos" do
      before do
        photo
        another_photo
      end

      it "changes the current user's profile photo to the photo posted" do
        post :change_user_photos, profile_photo: photo.id

        user.reload
        expect(user.profile.profile_photo).to eq(photo)
      end


      it "changes the current user's cover photo to the photo posted" do
        post :change_user_photos, cover_photo: photo.id

        user.reload
        expect(user.profile.cover_photo).to eq(photo)
      end


      it "errors if the photo posted is not one of the current user's" do
        post :change_user_photos, profile_photo: another_photo.id

        expect(flash[:danger]).to be_present
      end


      it "errors if a non-existent photo is submitted" do
        post :change_user_photos, profile_photo: 123456

        expect(flash[:danger]).to be_present
      end
    end


    describe "DELETE #destroy" do
      before do
        photo
        another_photo
      end

      it "deletes the current user's photo" do
        expect { 
         
          delete :destroy, id: photo.id 
        
        }.to change(user.photos, :count).by(-1)
      end


      it "redirects attempt to delete another user's photo" do
        expect {

          delete :destroy, id: another_photo.id

        }.not_to change(Photo, :count)

        expect(response).to redirect_to root_path
      end
    end

  end
end
