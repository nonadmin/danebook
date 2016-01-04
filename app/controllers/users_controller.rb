class UsersController < ApplicationController

  layout 'topbar_only'

  skip_before_action :require_sign_in, except: [:search]
  skip_before_action :store_location, except: [:search]
  skip_before_action :set_user

  before_action :redirect_signed_in_user, only: [:new, :create]


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


  def search
    @results = User.search_by_name(params[:search])
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
      redirect_to newsfeed_path
    end
  end

end
