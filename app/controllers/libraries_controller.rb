class LibrariesController < ApplicationController

  def create
    library = Library.new({owner_id: current_user.id, pattern_id: params[:pattern_id]})
    library.save
    redirect_to user_url(current_user)
  end
end