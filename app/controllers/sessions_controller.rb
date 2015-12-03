class SessionsController < ApplicationController

  def create
    user = User.find_by_email(session_params[:email])
    if user && user.authenticate(session_params[:password])
      sign_in(user)
      flash[:success] = "Welcome back, #{user.first_name.capitalize}"
      redirect_to timeline_path
    else
      flash[:danger] = "We couldn't sign you in!"
      redirect_to timeline_path
    end
  end


  private


  def session_params
    params.permit(:email, :password)
  end

end
