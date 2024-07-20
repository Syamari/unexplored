class ArtistsController < ApplicationController
  include ApplicationHelper

  def top_tracks
    @list = List.find(session[:list_id])
    @artist = Artist.find(params[:id])
    @selected_song = RSpotify::Artist.search(@artist.name).first.top_tracks(:JP).sample

    save_song

    url = @selected_song.embed.match(%r{https://embed\.spotify\.com/\?uri=spotify:track:(\w+)})
    @player_url = "https://open.spotify.com/embed/track/#{url[1]}"

    # 不要なメソッド？ private以下を参照
    # なお、このメソッドはrspec時にエラーなのでコメントアウト
    # エラー理由はrspecではartistはフォーム入力ではなく、単一で生成しているため、
    # spotifyを通してgenresテーブルに紐づいたデータが作成されないためエラーが出る
    # generate_genre_description_artist
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

  # ↓不要なメソッドの疑惑あり、内容もミスがあるが、書かれた目的が確定するまで消去を留保
  # おそらく、songs_controller.rbを参考に現在のこのコントローラーを書いた際に、
  # このメソッドを書いたと思われるが、実際には不要だった可能性がある

  def generate_genre_description_artist
    genre1 = @artist.genres.first.name.titleize
    genre2 = @artist.genres.first.name.titleize # ←firstではなくsecondとしたかったのかもしれない

    @genre_description = if genre1.blank?
                           genre2
                         elsif genre1 == genre2
                           genre1
                         else
                           "#{genre1} / #{genre2}"
                         end
  end
end
