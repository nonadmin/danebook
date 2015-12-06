class PostsController < UsersController

  layout 'user'
  before_action :set_user
  before_action :check_user, except: [:index]


  def index
    @post = @user.posts.new
  end


  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "Posted to Timeline!"
      redirect_to user_timeline_path(@user)
    else
      flash.now[:danger] = "Oops, something went wrong!"
      render :index
    end
  end


  private


  def post_params
    params.require(:post).permit(:user_id, :body)
  end

end
