class ProfilesController < ApplicationController
  
  skip_before_action :require_sign_in, only: [:show]


  def show
  end


  def edit
    @user = current_user
    @profile = current_user.profile
  end


  def update
    @user = current_user
    @profile = current_user.profile
    if @profile.update(profile_params)
      flash[:success] = "Profile Updated!"
      redirect_to user_profile_path(current_user.id)
    else
      flash[:danger] = "Oops, something went wrong!"
      render :edit
    end
  end


  private


  def profile_params
    params.require(:profile).permit( :about,
                                     :quote,
                                     :college,
                                     :hometown,
                                     :current_location,
                                     :phone )
  end


end
