class SongsController < ApplicationController
  include ApplicationHelper

  before_action :require_login
  before_action :set_list
  # リロード対策とAPIチェック用のメソッドです、デプロイ時にはコメントアウトを外してください
  before_action :redirect_if_reloaded, only: [:show]
  before_action :check_api_limit, only: [:show]

  MIN_ARTISTS_FOR_RECOMMEND = 3

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
    # 最初の3つのプレイリストから最もフォロワーが多いものを選択のが良いレコメンドになりやすいので 3つのプレイリストからランダムに選択
    @selected_song = @searched_playlists.first(3).max_by { |playlist| playlist.followers['total'] }.tracks.sample
  end

  def show
    if @list.artists.count < MIN_ARTISTS_FOR_RECOMMEND
      flash[:info] = 'レコメンドを行うにはリスト内にアーティストが3人以上必要です'
      redirect_to @list
      return
    end

    # 開発用のダミーロジック用のコードです、デプロイ時にはコメントアウトしてください
    #@recommend_genres = ["alternative"]
    # 一時的に以下の３行をコメントアウトして代わりにダミーを使えます、デプロイ時にはコメントアウトを外してください
    @unique_genres = get_unique_genre_names(@list)
    @related_artists_names = get_related_artists_names(@list)
    @recommend_genres = get_recommend_genres(@unique_genres, @related_artists_names).split(", ")

    @recommend_genre = @recommend_genres.sample
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

  def rate
    @rate = Rate.find_or_initialize_by(song_id: params[:song_id], user_id: current_user.id)
    @rate.score = params[:score]
    unless @rate.save
      redirect_to list_path(params[:list_id])
      flash[:info] = 'レーティングに失敗しました'
    end
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