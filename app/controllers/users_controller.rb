class UsersController < ApplicationController

  before_filter :require_signed_in!, except: [:new, :create, :activate_user]

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

  def index
    @users = User.all.page(params[:page])
    render :index
  end

  def show
    @user = User.find(params[:id])
    @patterns = @user.designs
    @library = @user.liked_patterns
    @followers = @user.followers
    render :show
  end

  def edit
    @user = current_user
    render :edit
  end

  def update
    current_user.update(user_params) if current_user.id.to_s == params[:id]
    redirect_to user_url(current_user)
  end

  def activate_user
    @user = User.find_by(activation_token: params[:activation_token])
    @user.activate = true
    @user.save
    login_user!(@user)
    redirect_to edit_user_url(@user)
  end

  def password_recovery
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :bio, :avatar)
  end
end