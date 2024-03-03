class ApplicationController < ActionController::Base
	add_flash_types :success, :info, :warning, :error

	require 'rspotify'
  RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'])
	ENV['ACCEPT_LANGUAGE'] = 'ja'

	require 'openai'

	private

	def require_login
    unless logged_in?
			flash[:info] = 'ログインまたはユーザー登録してください'
      redirect_to root_path
    end
  end

	def get_recommend_genre(genres)
		client = OpenAI::Client.new(access_token: ENV['OPENAI_CLIENT_ID'])
		response = client.chat(
			parameters: {
				model: 'gpt-3.5-turbo',
				messages: [
					{
						role: 'user',
						content: "You are a music recommender AI that handles a wide range of genres. The following array represents a set of music genres preferred by a certain user. Taking into account the granularity, BPM, and dynamics tendencies of the music genres in this array, please guess a popular music genre that is less related to the genres in this array, i.e., a popular music genre that this user has not yet listened to. Output one genre from it as a string in 1-3 words. However, please do not output genres that are too minor or too major. #{genres}"
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
