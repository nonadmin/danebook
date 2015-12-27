class PostsController < ApplicationController

  skip_before_action :require_sign_in, only: [:index]

  def index
    @post = @user.posts.new if @user == current_user
  end


  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:success] = "Posted to Timeline!"
      redirect_to user_timeline_path(@post.author)
    else
      flash.now[:danger] = "Oops, something went wrong!"
      @user = current_user
      render :index
    end
  end


  def destroy
    @post = current_user.posts.find_by_id(params[:id])
    if @post && @post.destroy
      flash[:success] = "Post deleted."
      redirect_to user_timeline_path(current_user)
    else
      flash[:danger] = "Oops, something went wrong!"
      redirect_to user_timeline_path(current_user)
    end
  end


  private


  def post_params
    params.require(:post).permit(:body)
  end


end
