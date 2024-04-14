class PasswordResetsController < ApplicationController
  def new; end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    not_authenticated if @user.blank?
  end

  def create
    @user = User.find_by(email: params[:email])
    @user&.deliver_reset_password_instructions!
    redirect_to login_path
    flash[:success] = 'パスワードリセットのメールを送信しました'
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end

    @user.password_confirmation = params[:user][:password_confirmation]
    if params[:user][:password].present? && @user.change_password(params[:user][:password])
      @user.update(reset_password_token: nil)
      logger.debug "Password has been successfully updated."
      redirect_to login_path
      flash[:success] = 'パスワードがリセットされました'
    else
      respond_to do |format|
        format.turbo_stream do
          flash.now[:error] = "パスワードのリセットに失敗しました。パスワードは英小文字と数字を含む8文字以上が必要です。"
          render turbo_stream: turbo_stream.replace("flash_message", partial: "shared/flash_message")
        end
      end
      logger.debug "Failed to update password."
    end
  end
end
