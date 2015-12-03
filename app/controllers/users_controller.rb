class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "Welcome to Danebook, #{@user.first_name.capitalize}"
      redirect_to timeline_path
    else
      flash.now[:danger] = "Oops, something went wrong!"
      render :new
    end
  end


  private


  def user_params
    params.require(:user).permit( :first_name,
                                  :last_name,
                                  :email,
                                  :password,
                                  :password_confirmation,
                                  :birthday,
                                  :gender )
  end

end
