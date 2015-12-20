class LikesController < ApplicationController

  skip_before_action :check_user

  def create
    @parent = find_parent
    @like = @parent.likes.build(creator: current_user)
    if @like.save
      flash[:success] = "You liked the #{@like.likeable_type}!"
    else
      flash[:danger] = "Oops, something went wrong!"
    end
    redirect_back_or(root_path)
  end


  def destroy
    @like = current_user.likes.find_by_id(params[:id])
    if @like && @like.destroy
      flash[:info] = "You unliked the #{@like.likeable_type}!"
    else
      flash[:danger] = "Oops, something went wrong!"
    end
    redirect_back_or(root_path)
  end


  private


  def find_parent
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

end
