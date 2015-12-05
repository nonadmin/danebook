class ProfilesController < UsersController
  
  before_action :set_user
  before_action :check_user, except: [:show]


  def show
    
  end


  def edit
    
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
