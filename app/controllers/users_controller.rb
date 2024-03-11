class UsersController < ApplicationController
	def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user) # ユーザー登録が成功したら、ユーザーを自動的にログインさせます
			flash[:info] = 'ユーザー登録 & ログインしました'
      redirect_to lists_path
    else
      respond_to do |format|
        format.turbo_stream do
              flash.now[:error] = "ユーザー登録に失敗しました！"
              render turbo_stream: turbo_stream.replace("flash_message", partial: "shared/flash_message")
        end   
      end
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'ユーザー情報を更新しました'
      redirect_to @user
    else
      flash.now[:error] = 'ユーザー情報の更新に失敗しました'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :user_name)
  end
end
