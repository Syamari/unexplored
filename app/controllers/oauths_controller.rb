class OauthsController < ApplicationController
  def oauth
    # 指定されたプロバイダの認証ページにユーザーをリダイレクトさせる
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    sorcery_fetch_user_hash provider
    email = @user_hash[:user_info]['email']
    # 既存のユーザーをプロバイダ情報を元に検索し、存在すればログイン
    if (@user = login_from(provider))
      redirect_to lists_path, notice: "#{provider.titleize}アカウントでログインしました"
    # プロバイダ情報ではユーザーが存在しないが、同メールアドレスのユーザーが存在する場合は、そのユーザーでログイン
    elsif (@user = User.find_by(email: email))
      reset_session
      auto_login(@user)
      redirect_to lists_path, info: "メールアドレスを使用してログインしました"
    else
      begin
        # ユーザーが存在しない場合はプロバイダ情報を元に新規ユーザーを作成し、ログイン
        signup_and_login(provider)
        redirect_to lists_path, notice: "#{provider.titleize}アカウントでログインしました"
      rescue StandardError => e
        Rails.logger.error "Googleログインエラー: #{e.message}"
        redirect_to root_path, alert: "#{provider.titleize}アカウントでのログインに失敗しました"
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider, :scope, :authuser, :prompt)
  end

  def signup_and_login(provider)
    @user = create_from(provider)
    reset_session
    auto_login(@user)
  end
end
