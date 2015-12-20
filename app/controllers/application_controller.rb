class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_sign_in
  before_action :store_location
  before_action :set_user


  def sign_in(user)
    user.regenerate_auth_token
    cookies.permanent[:auth_token] = user.auth_token
    @current_user = user
  end


  def sign_out
    @current_user = nil
    cookies.delete(:auth_token)
  end


  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token])
  end
  helper_method :current_user


  def signed_in_user?
    !!current_user
  end
  helper_method :signed_in_user?


  def require_sign_in
    unless signed_in_user?
      redirect_back_or(root_path)
      flash[:warning] = "Please sign in first!"
    end
  end

  # all actions scoped to current_user, no need to check params
  # against it (no user_id in params anymore)
  # def check_user
  #   unless params[:user_id] == current_user.id.to_s
  #     redirect_to root_path
  #     flash[:danger] = "Unauthorized"
  #   end
  # end


  def set_user
    @user = User.find_by_id(params[:user_id])
  end


  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end
  

  def store_location
    session[:forwarding_url] = request.fullpath if request.get?
  end

end
