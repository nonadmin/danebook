class PostsController < ApplicationController

  skip_before_action :require_sign_in, only: [:index]
  layout 'topbar_only', only: [:newsfeed]

  def index
    @post = @user.posts.new if @user == current_user
  end


  def newsfeed
    @post = current_user.posts.new
    @posts = current_user.newsfeed.paginate(page: params[:page], per_page: 10)
    @activity = current_user.friends_activity.first(10)
  end


  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:success] = "Posted to Timeline!"

      respond_to do |format|
        format.html { redirect_back_or(newsfeed_path) }
        format.js { } # hits create.js.erb
      end
    else
      flash[:danger] = "Oops, something went wrong!"

      respond_to do |format|
        format.html { redirect_back_or(newsfeed_path) }
        format.js { head :none }
      end
    end
  end


  def destroy
    @post = current_user.posts.find_by_id(params[:id])
    if @post && @post.destroy
      flash[:success] = "Post deleted."
      redirect_back_or(newsfeed_path)
    else
      flash[:danger] = "Oops, something went wrong!"
      redirect_back_or(newsfeed_path)
    end
  end


  private


  def post_params
    params.require(:post).permit(:body)
  end


end
