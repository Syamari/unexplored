class UserSessionsController < ApplicationController
	def new; end

  def create
    @user = login(params[:email], params[:password])
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
    flash.now.notice = '投稿を更新しました。'
  end
end
