module PhotosHelper

  def friends_only
    @user == current_user || @user.friends.include?(current_user)
  end

end
