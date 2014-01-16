class SessionsController < ApplicationController
  def new
    p '===========new==========='
  end

  def create
    p '=========create==========='
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or(user)
    else
      flash.now[:error] = '帐号或密码不正确' # Not quite right!
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
