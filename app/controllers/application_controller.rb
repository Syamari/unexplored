class ApplicationController < ActionController::Base
	add_flash_types :success, :info, :warning, :error

	require 'rspotify'

	API_LIMIT = 15 # API制限回数の設定
	API_LIMIT_DURATION = 15 * 60 # API制限の時間間隔の設定

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

def get_recommend_genres(genres, names, language, genre)
	client = OpenAI::Client.new(access_token: ENV.fetch('OPENAI_CLIENT_ID', nil))
	response = client.chat(
		parameters: {
			model: 'gpt-4o',
			messages: [
				{
					role: 'user',
					content: if language == "Japanese"
  "
					あなたはプロの音楽批評家です。あるユーザーが好きなジャンルと、好きなアーティストの例を提供するので、このユーザーが聞いたことがない可能性が高いジャンルを10個、3単語程度の英単語で出力してください。
					ただし、関連性の低いジャンルをただ上げればいいわけではないです。このユーザーはあくまで日本語の音楽、かつ#{genre}ジャンルの中から、自分が今まで聞いたことがないものを探しています。この２点を必ず厳守したうえで出力してください。
					また、enka と kayoukyoku は出力しないでください。J-Pop 以外の J-Genre は Japanese Genre というふうに表記してください。
					
					# 好きなジャンル: #{genres}
					# 好きなアーティストの例: #{names}
					
					出力は絶対に以下のフォーマットで行うことを厳守してください。他にテキストなどは一切出力しないでください。
					
					## フォーマット:
					genre1, genre2, genre3, ..., genre10

					"
              else
  "
					You are a popular music genre recommendation professional.
					I provide you with information on the genres that a given user likes and the artists they are most likely to like. 
					Please perform the following task considering the granularity of the music genres, BPM, and dynamic tendencies contained in that information as a professional.
					
					## Task:
					Guess, with rigorous deliberation, 10 popular music genres that meet the following criteria:
					1. The genres must be strictly selected from the designated genres described below.
					2. The genres must have little relevance to the genres contained in the provided array, i.e., the user has not yet listened to them.
					3. Each genre must be expressed in 1-3 words.
					4. The name of the genre must be written in English.
					5. Adhere strictly to the Designated Country if specified.
					6. Adhere strictly to the Designated Genre if specified.
					Output these 10 genres in the Specified Format.
					
					## Input:
					- User's favorite music genres: #{genres}
					- Artists this user is likely to like: #{names}
					- Designated Genre: #{genre}
					- Designated Country: #{language}
					
					## Specified Format:
					genre1, genre2, genre3, ..., genre10
					**Output only the Specified Format data. Do not write any explanatory text.**
					This is a complex task where multiple conditions may overlap, so always be cautious and strictly adhere to the status of all conditions.
					"
              end
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
		if first_timestamp.nil? || Time.now.to_i - first_timestamp > API_LIMIT_DURATION
			session[:first_timestamp] = Time.now.to_i
			session[:count] = 1
		else
			# 制限を超えている場合はリダイレクト
			if count >= API_LIMIT
				flash[:info] = 'しばらく時間を置いてから再度お試しください'
				redirect_to lists_path
			else
				# 15分以内で制限を超えていない場合は回数を増やす
				session[:count] = count + 1
			end
		end
	end
end
