class SongsController < ApplicationController
  include ApplicationHelper

  before_action :require_login
  before_action :set_list
  before_action :redirect_if_reloaded
  before_action :check_api_limit

  def show
    if @list.artists.count < 3
      flash[:info] = 'レコメンドを行うにはアーティストを3人以上追加してください'
      redirect_to @list
      return
    end

    #ダミーロジック用のコードです
    @recommend_genre = "math rock"

    @unique_genres = get_unique_genre_names(@list)
    #一時的にコメントアウトして代わりにダミーのコードを使えます
    @recommend_genre = get_recommend_genre(@unique_genres)

    begin
      searched_playlists = RSpotify::Playlist.search(@recommend_genre)
    rescue RestClient::BadRequest => e
      flash[:info] = '今回はレコメンドジャンルの取得に失敗しました'
      redirect_to @list
      return
    end  

    if searched_playlists.empty?
			flash[:info] = 'レコメンドの生成に失敗しました'
			redirect_to @list
			return
		end
    
    @selected_song = searched_playlists.first(3).max_by { |playlist| playlist.followers['total'] }.tracks.sample
    url = @selected_song.embed.match(/https:\/\/embed\.spotify\.com\/\?uri=spotify:track:(\w+)/)
    @player_url = "https://open.spotify.com/embed/track/#{url[1]}"
    generate_genre_description
    session[:visited] = true
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
  
    if genre1.blank?
      @genre_description = genre2
    elsif genre1 == genre2
      @genre_description = genre1
    else
      @genre_description = "#{genre1} / #{genre2}"
    end
  end

end