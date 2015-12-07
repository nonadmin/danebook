class LikesController < ApplicationController

  layout 'user'

  def create
    @parent = find_parent
    @like = @parent.likes.build(creator: current_user)
    if @like.save
      flash[:success] = "You liked the #{@like.likeable_type}!"
    else
      flash[:danger] = "Oops, something went wrong!"
    end
    parent_redirect
  end


  def destroy
    @like = Like.find_by_id(params[:id])
    @parent = @like.likeable
    if @like.destroy
      flash[:info] = "You unliked the #{@like.likeable_type}!"
    else
      flash[:danger] = "Oops, something went wrong!"
    end
    parent_redirect
  end


  private


  def parent_redirect
    case @like.likeable_type
    when "Post"
      redirect_to user_timeline_path(@parent.author)
    when "Comment"
      redirect_to user_timeline_path(@parent.commentable.author)
    else
      redirect_to :root
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
