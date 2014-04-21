class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def activate
    @user = User.find_by(activation_token: params[:activate])
    @user.activate = true
    @user.save
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end