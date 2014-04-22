class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      UserMailer.welcome_email(@user).deliver!
      redirect_to root_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def activate_user
    @user = User.find_by(activation_token: params[:activation_token])
    @user.activate = true
    @user.save
    login_user!(@user)
    redirect_to user_url(@user)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end