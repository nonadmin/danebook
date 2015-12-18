class CommentsController < ApplicationController

  layout 'user'

  def create
    @parent = find_parent
    @comment = @parent.comments.build(comment_params)
    @comment.author = current_user
    if @comment.save
      flash[:success] = "Commented!"
      redirect_back_or(root_path)
    else
      flash[:danger] = "Oops, something went wrong!"
      render_parent
    end
  end


  def destroy
    # current_user.comments(find) scope to current_user
    @comment = Comment.find_by_id(params[:id])
    if @comment.author == current_user && @comment.destroy
      flash[:info] = "Comment deleted."
      redirect_back_or(root_path)
    else
      flash[:danger] = "Oops, something went wrong!"
      redirect_back_or(root_path)
    end
  end


  private


  def comment_params
    params.require(:comment).permit(:body)
  end


  def render_parent
    if @comment.commentable_type == "Post"
      @user = @comment.commentable.author
      @post = @user.posts.new if @user == current_user
      render template: 'posts/index'
    end
  end


  def find_parent
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

end