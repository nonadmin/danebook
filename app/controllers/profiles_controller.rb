class ProfilesController < UsersController
  
  layout 'user'
  before_action :set_user
  before_action :check_user, except: [:show]


  def show
    store_location
  end


  def edit
    store_location
  end


  def update
    if @user.update(user_params)
      flash[:success] = "Profile Updated!"
      redirect_to user_profile_path(@user.id)
    else
      flash[:danger] = "Oops, something went wrong!"
      render :edit
    end
  end

end
