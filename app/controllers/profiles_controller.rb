class ProfilesController < ApplicationController
  
  before_action :check_user, except: [:show]
  skip_before_action :require_sign_in, only: [:show]


  def show
  end


  def edit
  end


  def update
    if @user.profile.update(profile_params)
      flash[:success] = "Profile Updated!"
      redirect_to user_profile_path(@user.id)
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
