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

  def get_recommend_genres(genres, names)
    client = OpenAI::Client.new(access_token: ENV.fetch('OPENAI_CLIENT_ID', nil))
    response = client.chat(
      parameters: {
        model: 'gpt-3.5-turbo',
        messages: [
          {
            role: 'user',
            content: "You are a pop music genre recommendation professional familiar with the 15 major musics of Pop, R&B, Soul, Rock, Alternative, Indie, Country, Electronic, Folk, Hiphop, Jazz, Metal, Punk, Blues, Experimental.
            Now, I provide you with information on the genres that a given user likes and the artists they are most likely to like. So please perform the following task considering the granularity of the music genres, BPM, and dynamics tendencies contained in those pieces of information as professional.
            Task: Guess, with rigorous deliberation, 10 popular music genres that can be expressed in 1-3 words and that have little relevance to the genres contained in this array, i.e., that this user has not yet listened to. Then, output these 10 genres in the specified format. Do not write any text. Be sure to output only the specified format data to me.
            ##this User's favorite music genres: #{genres}
            ##Artists this user is likely to like: #{names}
            ##Specified format: genre1, genre2, genre3, ... , genre10  "
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
