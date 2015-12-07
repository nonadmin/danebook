class UsersController < ApplicationController

  skip_before_action :require_sign_in, only: [:index, :show, :new, :create]

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


  def set_user
    @user = User.find_by_id(params[:user_id])
  end


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
                                  :gender,
                                  :about,
                                  :quote,
                                  :college,
                                  :hometown,
                                  :current_location,
                                  :phone ] )
  end

end
