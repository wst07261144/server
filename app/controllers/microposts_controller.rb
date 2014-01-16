class MicropostsController < ApplicationController

  before_action :sign_in_user ,only: [:destroy,:create]

  def destroy

  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def index

  end

    private

    def micropost_params
      params.require(:micropost).permit(:content)
    end
end
