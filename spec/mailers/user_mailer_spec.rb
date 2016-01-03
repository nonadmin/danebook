require "rails_helper"

describe UserMailer do
  let(:user) { build(:user) }

  before (:each) do
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
  end

  after(:each) do
    ActionMailer::Base.deliveries.clear
  end  


  describe "Welcome Email" do
    it "sends an email to new users when they signup" do
      user.save

      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end


    it "the email is sent to the new user's email address" do
      user.save

      expect(ActionMailer::Base.deliveries.first.to).to match_array(user.email)
    end
  end
end
