class PostsController < UsersController

  layout 'user'
  before_action :set_user


  def index
    @post = @user.posts.new if @user == current_user
  end


  def create
    @post = Post.new(post_params)
    if @user == current_user && @post.save
      flash[:success] = "Posted to Timeline!"
      redirect_to user_timeline_path(@user)
    else
      flash.now[:danger] = "Oops, something went wrong!"
      render :index
    end
  end


  def destroy
    @post = Post.find_by_id(params[:id])
    if @post.author == current_user && @post.destroy
      flash[:success] = "Post deleted."
      redirect_to user_timeline_path(current_user)
    else
      flash[:danger] = "Oops, something went wrong!"
      redirect_to user_timeline_path(current_user)
    end
  end


  private


  def post_params
    params.require(:post).permit(:body, :user_id)
  end


end
