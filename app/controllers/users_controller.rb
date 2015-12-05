class UsersController < ApplicationController

  skip_before_action :require_sign_in, only: [:new, :create, :show]
  before_action :check_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  end


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

  
  def edit
    @user = User.find(params[:id])
  end


  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile Updated!"
      redirect_to @user
    else
      flash.now[:danger] = "Oops, something went wrong!"
      render :edit
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
                                  :gender,
                                  :about,
                                  :quote,
                                  :college,
                                  :home_town,
                                  :current_town,
                                  :phone )
  end

end
