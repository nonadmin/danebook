class CommentsController < ApplicationController

  layout 'user'

  def create
    @comment = current_user.comments.new(comment_params)
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
    if @comment.destroy
      flash[:info] = "Comment deleted."
      redirect_or_render
    else
      flash[:danger] = "Oops, something went wrong!"
      redirect_or_render
    end
  end


  private


  def comment_params
    params.require(:comment).permit(:commentable_type, 
                                    :commentable_id, 
                                    :body, 
                                    :parent_id)
  end


  def redirect_or_render(method = nil)
    if @comment.commentable_type == "Post"
      if method == :render
        @user = User.find_by_id(comment_params[:parent_id])
        @post = @user.posts.new if @user == current_user
        render template: 'posts/index'
      else # redirect
        redirect_to user_timeline_path(comment_params[:parent_id])
      end
    end
  end

end
