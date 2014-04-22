class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
    params[:user][:email], params[:user][:password])

    if user.nil?
      flash.now[:errors] ||=[]
      flash.now[:errors] << "Couldn't find user"
      render :new
    elsif !user.activate?
      flash.now[:errors] ||= []
      flash.now[:errors] << "Check your email for activation"
      render :new
    else
      login_user!(user)
      redirect_to user_url(user)
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token]= nil

    redirect_to new_session_url
  end

end