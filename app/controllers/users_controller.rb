class UsersController < ApplicationController

  before_action :signed_in_user, only:[:edit,:update,:index]
  before_action :correct_user, only: [:edit,:update]

  def index
    @users =  User.all
  end

  def new
    @user=User.new
  end

  def show
    @user = User.find params[:id]
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user #转向地址我们直接写了 @user，而没用 user_path，Rails 会自动转向到用户的资料页面
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,:password_confirmation)
  end

  def signed_in_user
    #redirect_to signin_url ,notice:'Please login' if !signed_in?
    #flash[:error] 也可以使用上述的简便方式，但 flash[:success] 却不可以。
   unless signed_in?
     store_location
     redirect_to signin_url ,notice:'Please login'
   end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end
end
