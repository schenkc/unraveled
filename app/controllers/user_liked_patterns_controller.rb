class UserLikedPatternsController < ApplicationController

  def create
    library = UserLikedPattern.find_or_create_by({owner_id: current_user.id, pattern_id: params[:pattern_id]})
    redirect_to user_url(current_user)
  end
end