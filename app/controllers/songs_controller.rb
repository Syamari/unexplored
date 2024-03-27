class SongsController < ApplicationController
  include ApplicationHelper

  before_action :require_login
  before_action :set_list
  # APIチェック用のメソッドです、デプロイ時にはコメントアウトを外してください
  #before_action :redirect_if_reloaded
  #before_action :check_api_limit

  def select_song
    begin
      @searched_playlists = RSpotify::Playlist.search(@recommend_genre)
    rescue RestClient::BadRequest
      flash[:info] = '今回はレコメンドジャンルの取得に失敗しました'
      redirect_to @list
      return
    end  

    if @searched_playlists.empty?
			flash[:info] = 'レコメンドの生成に失敗しました'
			redirect_to @list
			return
		end

    @selected_song = @searched_playlists.first(3).max_by { |playlist| playlist.followers['total'] }.tracks.sample
  end

  def show
    if @list.artists.count < 3
      flash[:info] = 'レコメンドを行うにはリスト内にアーティストが3人以上必要です'
      redirect_to @list
      return
    end

    @unique_genres = get_unique_genre_names(@list)
    # 開発用のダミーロジック用のコードです、デプロイ時にはコメントアウトしてください
    @recommend_genre = "alternative"
    # 一時的にコメントアウトして代わりにダミーを使えます、デプロイ時にはコメントアウトを外してください
    #@recommend_genre = get_recommend_genre(@unique_genres)

    select_song
    save_song

    url = @selected_song.embed.match(/https:\/\/embed\.spotify\.com\/\?uri=spotify:track:(\w+)/)
    @player_url = "https://open.spotify.com/embed/track/#{url[1]}"
    generate_genre_description

    session[:visited] = true
  end

  def save_song
    artist_name = @selected_song.artists.first.name
    artist = Artist.find_or_create_by(name: artist_name)
    song_name = @selected_song.name
    @song = Song.find_or_create_by(name: song_name, artist:)
  end

  private

	def set_list
		@list = List.find(params[:list_id])
	end

  def redirect_if_reloaded
    if session[:visited]
      redirect_to lists_path
    end
  end

  def generate_genre_description
    genre1 = @selected_song.artists.first&.genres&.first&.titleize
    genre2 = @recommend_genre.titleize
  
    @genre_description = if genre1.blank?
      genre2
                         elsif genre1 == genre2
      genre1
                         else
      "#{genre1} / #{genre2}"
                         end
  end

end