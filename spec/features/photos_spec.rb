require "rails_helper"

feature "User Photos" do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:photo) { create(:photo, author: user) }
  let(:another_photo) { create(:photo) }

  context "visitor" do
    before :each do
      user
      photo
    end

    feature "User's Photo gallery/index" do
      scenario "Visitors can view any user's photo gallery" do
        visit user_photos_path(user)
        photo.reload # background processing is off, but will still give missing url

        expect(page).to have_xpath("//img[@src=\"#{photo.image.url(:small)}\"]")
      end


      scenario "Visitors do not have links to view individual photos show pages" do
        visit user_photos_path(user)

        expect(page).not_to have_link("", href: photo_path(photo))
      end


      scenario "A message is shown if the user doesn't have any photos" do
        visit user_photos_path(another_user)

        expect(page).to have_content("No Photos")
      end
    end
  end


  context "signed in user" do
    before do
      sign_in(user)
    end

    feature "Uploading" do
      let(:photo_url) do
        ActionController::Base.new.view_context.
          asset_url("missing_small.png", host: "http://localhost:3000")
      end

      scenario "Add a new photo by uploading from computer" do
        visit new_photo_path
        attach_file "photo[image]", "#{Rails.root}/spec/support/test.png"
        expect { click_button("Upload Photo") }.to change(user.photos, :count).by(1)    
      end


      scenario "Add a new photo from a web address" do
        visit new_photo_path
        fill_in "photo[url]", with: photo_url
        expect { click_button("Upload Photo") }.to change(user.photos, :count).by(1)    
      end
    end


    feature "User's Photo gallery/index" do
      scenario "Links to individual photos appear if the user is a friend" do
        another_photo.author.friends << user
        visit user_photos_path(another_photo.author)

        expect(page).to have_link("", href: photo_path(another_photo))
      end
    end


    feature "Show individual Photo" do
      scenario "View an individual photo at a larger size" do
        visit photo_path(photo)
        photo.reload # background processing issue

        expect(page).to have_xpath("//img[@src=\"#{photo.image.url(:large)}\"]")
      end


      scenario "Restricted to photo author's friends" do
        visit photo_path(another_photo)

        expect(page).to have_content("Friends Only!")
      end
    end


    feature "Delete" do
      scenario "User can delete their photos" do
        visit photo_path(photo)

        expect { click_link("Delete Photo") }.to change(user.photos, :count).by(-1)
      end
    end


    feature "Setting Profile and Cover photos" do
      scenario "Select a photo to used as the profile/avatar" do
        visit photo_path(photo)
        click_link("Set as Profile")

        expect(page).to have_content("Your Profile Photo/Avatar has been changed!")
        expect(page).to have_content("Profile Photo")
      end


      scenario "Select a photo to be used as the cover photo" do
        visit photo_path(photo)
        click_link("Set as Cover")

        expect(page).to have_content("Your Cover Photo has been changed!")
        expect(page).to have_content("Cover Photo")
      end
    end
  end

end