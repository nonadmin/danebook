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
      expect(photo).to validate_attachment_size(:image).less_than(2.megabytes)
    end
  end
end
