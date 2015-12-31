class PhotosController < ApplicationController

  skip_before_action :require_sign_in, only: [:index]
  layout 'topbar_only', only: [:new, :show]


  def new
    @photo = current_user.photos.new
  end

end
