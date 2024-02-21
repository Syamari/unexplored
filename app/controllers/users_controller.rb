class UsersController < ApplicationController
	def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
			flash[:success] = 'ユーザー登録しました'
      redirect_to login_path
    else
      respond_to do |format|
        format.turbo_stream do
              flash.now[:error] = "ユーザー登録に失敗しました！"
              render turbo_stream: turbo_stream.replace("flash_message", partial: "shared/flash_message")
        end   
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :user_name)
  end
end
