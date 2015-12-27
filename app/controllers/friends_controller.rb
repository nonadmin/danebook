class FriendsController < ApplicationController

  skip_before_action :require_sign_in, only: [:index]

  def index
    # set friends var
  end


  def create
    new_friend = User.find_by_id(params[:id])
    friending = current_user.initiated_friendings.build(friend_receiver: new_friend)
    if friending.save
      flash[:success] = "You and #{new_friend.profile.full_name} are now friends!"
    else
      flash[:danger] = "Oops, something went wrong!"
    end
    redirect_back_or(root_path)
  end


  def destroy
    friending = current_user.initiated_friendings.find_by_friend_id(params[:id])
    if friending && friending.destroy
      other_user_name = friending.friend_receiver.profile.full_name
      flash[:info] = "You are no longer friends with #{other_user_name}."
    else
      flash[:danger] = "Oops, something went wrong!"
    end
    redirect_back_or(root_path)
  end


end
