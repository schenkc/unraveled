class FollowersController < ApplicationController
  
  def create
    current_user.followers << User.find(params[:user_id])
    redirect_to user_url(current_user)
  end
end