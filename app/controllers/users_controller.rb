class UsersController < ApplicationController

  layout 'signup'

  skip_before_action :require_sign_in
  skip_before_action :store_location
  skip_before_action :set_user

  before_action :redirect_signed_in_user


  def new
    @user = User.new
    @user.build_profile
  end


  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "Welcome to Danebook, #{@user.profile.first_name.capitalize}"
      redirect_to user_profile_path(@user)
    else
      flash.now[:danger] = "Oops, something went wrong!"
      render :new
    end
  end


  private


  def user_params
    params.require(:user).permit( :id,
                                  :email,
                                  :password,
                                  :password_confirmation,
                                  profile_attributes: [
                                  :id,
                                  :first_name,
                                  :last_name,
                                  :birthday,
                                  :gender ] )
  end


  def redirect_signed_in_user
    if signed_in_user?
      redirect_to user_timeline_path(current_user)
    end
  end

end
