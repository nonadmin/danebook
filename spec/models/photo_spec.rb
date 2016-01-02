require 'rails_helper'
require 'support/likeable'
require 'support/commentable'

describe Photo do
  let(:photo) { build(:photo) }

  it_behaves_like "likeable"
  it_behaves_like "commentable"

  describe 'attributes' do
    it "has_attached_file :image" do
      expect(photo).to have_attached_file(:image)
    end


    it "saves image from url if url is set" do
      photo.image = nil
      photo.url = ActionController::Base.new.view_context.asset_url("icon_photo_small.png", host: "http://localhost:3000")
      photo.save
      expect(photo.image_file_name).to eq("icon_photo_small.png")
    end
  end


  describe 'validations' do
    it "is valid with an image and author" do
      expect(photo).to be_valid
    end


    it "is invalid without an author" do
      photo.author_id = 1234

      expect(photo).not_to be_valid
    end


    it "is invalid without an image" do
      photo.image = nil  

      expect(photo).not_to be_valid
    end


    it "validates image content type" do
      expect(photo).to validate_attachment_content_type(:image).
                       rejecting('text/plain', 'text/xml')
    end


    it "validates image size" do
      expect(photo).to validate_attachment_size(:image).less_than(5.megabytes)
    end
  end
end
