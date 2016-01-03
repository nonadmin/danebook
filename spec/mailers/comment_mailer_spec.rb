require "rails_helper"

describe CommentMailer do
  before (:each) do
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
  end

  after(:each) do
    ActionMailer::Base.deliveries.clear
  end 

  describe "New Comment Email" do
    let(:user) { build(:user) }
    let(:post) { create(:post, author: user) }
    let(:photo) { create(:photo, author: user) }
    let(:comment) { build(:comment) }

    it "sends an email to a user when their post or photo has a new comment" do
      comment.commentable = post
      ActionMailer::Base.deliveries.clear # have to clear welcome emails
      comment.save

      expect(ActionMailer::Base.deliveries.count).to eq(1)
      expect(ActionMailer::Base.deliveries.first.to).to match_array(user.email)
    end


    it "the email links to the photo show page for photo comments" do
      comment.commentable = photo
      ActionMailer::Base.deliveries.clear
      comment.save

      expect(ActionMailer::Base.deliveries.first.part[1].body).to include(photo_url(photo))
    end


    it "the email links to the timeline for post comments" do
      comment.commentable = post
      ActionMailer::Base.deliveries.clear
      comment.save

      expect(ActionMailer::Base.deliveries.first.part[1].body).to include(user_timeline_path(user))
    end
  end
end
