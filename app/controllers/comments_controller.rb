class CommentsController < ApplicationController

  layout 'user'

  def create
    @parent = find_parent
    @comment = @parent.comments.build(comment_params)
    @comment.author = current_user
    if @comment.save
      flash[:success] = "Commented!"
      redirect_or_render
    else
      flash[:danger] = "Oops, something went wrong!"
      redirect_or_render(:render)
    end
  end


  def destroy
    @comment = Comment.find_by_id(params[:id])
    if @comment.author == current_user && @comment.destroy
      flash[:info] = "Comment deleted."
      redirect_or_render
    else
      flash[:danger] = "Oops, something went wrong!"
      redirect_or_render
    end
  end


  private


  def comment_params
    params.require(:comment).permit(:body)
  end


  def redirect_or_render(method = nil)
    if @comment.commentable_type == "Post"
      @user = @comment.commentable.author
      if method == :render
        @post = @user.posts.new if @user == current_user
        render template: 'posts/index'
      else # redirect
        redirect_to user_timeline_path(@user)
      end
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
