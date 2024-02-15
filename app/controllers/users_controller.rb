class UsersController < ApplicationController
	def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
		binding.pry
    if @user.save
			flash[:success] = '登録しました'
      redirect_to login_path
    else
			flash[:success] = '登録失敗'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :user_name)
  end
end
