class FollowersController < ApplicationController

before_filter :require_signed_in!

  def create
    current_user.leaders << User.find(params[:user_id])
    redirect_to user_url(params[:user_id])
  end

  def destroy
    f = Follower.find_by(leader_id: params[:id], follower_id: current_user.id)
    f.destroy
    redirect_to user_url(f.leader_id)
  end
end