class LikesController < UsersController

  layout 'user'
  before_action :set_user

  def create
    like = @user.likes.new(like_params)
    if like.save
      flash[:success] = "You liked the #{like_params[:likeable_type]}!"
    else
      flash[:danger] = "Oops, something went wrong!"
    end
    redirect_to :back
  end


  def destroy
    like = Like.find_by_id(params[:id])
    if like.destroy
      flash[:info] = "You unliked the #{like.likeable_type}!"
    else
      flash[:danger] = "Oops, something went wrong!"
    end
    redirect_to :back
  end


  private


  def like_params
    params.permit(:likeable_id, :likeable_type)
  end

end
