class LikesController < ApplicationController

  layout 'user'

  def create
    @like = current_user.likes.new(like_params)
    if @like.save
      flash[:success] = "You liked the #{@like.likeable_type}!"
    else
      flash[:danger] = "Oops, something went wrong!"
    end
    polymorphic_redirect
  end


  def destroy
    @like = Like.find_by_id(params[:id])
    if @like.destroy
      flash[:info] = "You unliked the #{@like.likeable_type}!"
    else
      flash[:danger] = "Oops, something went wrong!"
    end
    polymorphic_redirect
  end


  private


  def like_params
    params.permit(:parent_id, :likeable_id, :likeable_type)
  end


  def polymorphic_redirect
    case @like.likeable_type
    when "Post"
      redirect_to user_timeline_path(like_params[:parent_id])
    when "Comment"
      redirect_to user_timeline_path(like_params[:parent_id])
    else
      redirect_to :root
    end
  end

end
