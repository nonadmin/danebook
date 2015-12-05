class StaticPagesController < ApplicationController

  skip_before_action :require_sign_in, only: [:timeline, :friends, :photos]
  

  def timeline
    
  end


  def friends
    
  end


  def photos
    
  end


end
