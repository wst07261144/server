module SessionsHelper
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end
  def current_user=(user)
    @current_user = user         #login相关
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in?
    !current_user.nil?    #此处current_user是 def current_user方法
  end
  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def sign_out
    current_user.update_attribute(:remember_token,User.encrypt(User.new_remember_token))
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def store_location
    session[:return_to] = request.fullpath if request.get?
  end

  def redirect_back_or default
    redirect_to (session[:return_to]||default)
    session[:return_to] = nil
  end

  def signed_in_user
    #redirect_to signin_url ,notice:'Please login' if !signed_in?
    #flash[:error] 也可以使用上述的简便方式，但 flash[:success] 却不可以。
    unless signed_in?
      store_location
      redirect_to signin_url ,notice:'Please login'
    end
  end
end
