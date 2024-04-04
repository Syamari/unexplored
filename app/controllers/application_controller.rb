class ApplicationController < ActionController::Base
	add_flash_types :success, :info, :warning, :error

	require 'rspotify'

	begin
		RSpotify.authenticate(ENV.fetch('SPOTIFY_CLIENT_ID', nil), ENV.fetch('SPOTIFY_SECRET_ID', nil))
  rescue SocketError => e
    flash[:error] = "APIへの接続に失敗しました"
    redirect_to root_path
	end

	ENV['ACCEPT_LANGUAGE'] = 'ja'

	require 'openai'

	private

	def require_login
    unless logged_in?
			flash[:info] = 'ログインまたはユーザー登録してください'
      redirect_to root_path
    end
  end

	def get_recommend_genre(genres, names)
		client = OpenAI::Client.new(access_token: ENV.fetch('OPENAI_CLIENT_ID', nil))
		response = client.chat(
			parameters: {
				model: 'gpt-3.5-turbo',
				messages: [
					{
						role: 'user',
						content: "You are a pop music genre recommendation professional familiar with the 15 major musics of Pop, R&B, Soul, Rock, Alternative, Indie, Country, Electronic, Folk, Hiphop, Jazz, Metal, Punk, Blues, Experimental. The following array represents a set of music genres preferred by a certain user. Taking into account the granularity, BPM, and dynamics tendencies of the music genres in this array, please guess 10 popular music genre that can be expressed in 1-3 words and is less related to the genres in this array, i.e., a popular music genre that this user has not yet listened to. And output only one genre from these 10 genres as a string in 1-3 words. Please note that you only have to output one genre, although there are 10 genres to guess. However, please do not output genres that are too minor or too major. #{genres}  Also, for additional information, please consider that this user may prefer the following artists. #{names}"
					}
				]
			}
		)
		response.dig('choices', 0, 'message', 'content')
	end

	def check_api_limit
		# sessionに保存された最初のタイムスタンプと回数を取得
		first_timestamp = session[:first_timestamp]
		count = session[:count] || 0
	
		# 最初のタイムスタンプがない、または15分経過している場合はリセット
		if first_timestamp.nil? || Time.now.to_i - first_timestamp > 15 * 60
			session[:first_timestamp] = Time.now.to_i
			session[:count] = 1
		else
			# 制限を超えている場合はリダイレクト
			if count >= 15
				flash[:info] = 'しばらく時間を置いてから再度お試しください'
				redirect_to lists_path
			else
				# 15分以内で制限を超えていない場合は回数を増やす
				session[:count] = count + 1
			end
		end
	end

end
