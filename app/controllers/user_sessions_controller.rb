class UserSessionsController < ApplicationController
	def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
			flash[:info] = 'ログインしました'
      redirect_back_or_to lists_path
    else
      respond_to do |format|
        format.turbo_stream do
              flash.now[:error] = "ログインに失敗しました！"
              render turbo_stream: turbo_stream.replace("flash_message", partial: "shared/flash_message")
        end   
      end
    end
  end

	def destroy
    logout
    redirect_to root_path
    flash[:info] = 'ログアウトしました'
  end
end
