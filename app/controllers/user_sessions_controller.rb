class UserSessionsController < ApplicationController
	def new; end

  def create
    @user = login(params[:email], params[:password])
		binding.pry
    if @user
			flash[:success] = 'ログインしました'
      redirect_back_or_to root_path
    else
			flash[:success] = 'ログイン失敗'
      render :new
    end
  end

	def destroy
    logout
    redirect_to root_path
  end
end
