class FollowersController < ApplicationController
  
  def create
    current_user.leaders << User.find(params[:user_id])
    redirect_to user_url(current_user)
  end
  
  def destroy
    f = Follower.find(params[:id])
    f.destroy
    redirect_to user_url(params[:user_id])
  end
end