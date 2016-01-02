class PhotosController < ApplicationController

  skip_before_action :require_sign_in, only: [:index]
  before_action :set_photo, only: [:show]
  before_action :friends_only, only: [:show]
  layout 'topbar_only', only: [:new, :show, :create]


  def new
    @photo = current_user.photos.new
  end


  def create
    @photo = current_user.photos.new(photo_params)
    if @photo.save
      flash[:success] = "New Photo Uploaded!"
      redirect_to @photo
    else
      flash.now[:danger] = "Oops, something went wrong!"
      render :new
    end
  end


  def show
  end


  def index
    @photos = @user.photos
  end


  def destroy
    @photo = current_user.photos.find_by_id(params[:id])
    if @photo && @photo.destroy
      flash[:info] = "Photo Deleted"
      redirect_to user_photos_path(@photo.author)
    else
      flash.now[:danger] = "Oops, something went wrong!"
      redirect_back_or(root_path)
    end
  end


  private


  def photo_params
    params.require(:photo).permit(:image, :url)
  end


  def friends_only
    friends = @photo.author.friends

    unless @photo.author == current_user ||
           friends.include?(current_user)
      flash[:danger] = "Friends Only!"
      redirect_to root_path
    end
  end


  def set_photo
    @photo = Photo.find_by_id(params[:id])
  end

end
