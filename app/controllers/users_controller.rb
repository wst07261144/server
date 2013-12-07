class UsersController < ApplicationController
  def new
    @user=User.new
  end
  def show
    @user = User.find params[:id]
  end
  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user #转向地址我们直接写了 @user，而没用 user_path，Rails 会自动转向到用户的资料页面
    else
      render 'new'
    end
  end



  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
