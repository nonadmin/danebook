class CommentsController < ApplicationController

  skip_before_action :check_user

  def create
    @parent = find_parent
    @comment = @parent.comments.build(comment_params)
    @comment.author = current_user
    if @comment.save
      flash[:success] = "Commented!"
      
      respond_to do |format|
        format.html { redirect_back_or(root_path) }
        format.js {  } # create.js.erb
      end
    else
      flash[:danger] = "Oops, something went wrong!"

      respond_to do |format|
        format.html { redirect_back_or(root_path) }
        format.js { head :none }
      end
    end
  end


  def destroy
    # current_user.comments(find) scope to current_user
    @comment = current_user.comments.find_by_id(params[:id])
    if @comment && @comment.destroy
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

  
  # def render_parent
  #   if @comment.commentable_type == "Post"
  #     @user = @comment.commentable.author
  #     @post = @user.posts.new if @user == current_user
  #     render template: 'posts/index'
  #   elsif  @comment.commentable_type == "Photo"
  #     @photo = @comment.commentable
  #     render template: 'photos/show', layout: 'topbar_only'
  #   end
  # end


  def find_parent
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

end
