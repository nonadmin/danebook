class UserMailer < ApplicationMailer
  default from: "noreply@test.nightiron.com"


  def welcome(user)
    @suggested_friends = User.with_profile_photos.sample(3)
    @user = user
    mail(to: @user.email, subject: "Welcome to Danebook!")
  end
end
