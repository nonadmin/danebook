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
      flash[:success] = "New Photo added.  It is processing, reload this page 
                         after a moment and the photo will appear below."
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


  def change_user_photos
    new_cover = current_user.photos.find_by_id(params[:cover_photo])
    new_profile = current_user.photos.find_by_id(params[:profile_photo])

    if new_cover && current_user.profile.update(cover_photo: new_cover)
      flash[:success] = "Your Cover Photo has been changed!"
      redirect_to photo_path(new_cover)

    elsif new_profile && current_user.profile.update(profile_photo: new_profile)
      flash[:success] = "Your Profile Photo/Avatar has been changed!"
      redirect_to photo_path(new_profile)
      
    else
      flash[:danger] = "Oops, something went wrong."
      redirect_back_or(root_path)
    end
  end


  private


  def photo_params
    params.require(:photo).permit(:image, :url)
  end

  # model method?  on photo?
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
