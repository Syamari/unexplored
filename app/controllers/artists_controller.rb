class ArtistsController < ApplicationController
  include ApplicationHelper
  # リロード対策とAPIチェック用のメソッドです、デプロイ時にはコメントアウトを外してください
  before_action :redirect_if_reloaded, only: [:top_tracks]

  def top_tracks
		@list = List.find(session[:list_id])
    @artist = Artist.find(params[:id])
    @selected_song = RSpotify::Artist.search(@artist.name).first.top_tracks(:JP).sample

		save_song

		url = @selected_song.embed.match(/https:\/\/embed\.spotify\.com\/\?uri=spotify:track:(\w+)/)
		@player_url = "https://open.spotify.com/embed/track/#{url[1]}"
		generate_genre_description_artist

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

  def redirect_if_reloaded
    if session[:visited]
      redirect_to list_path(session[:list_id])
    end
  end

  def generate_genre_description_artist
    genre1 = @artist.genres.first.name.titleize
    genre2 = @artist.genres.first.name.titleize
  
    @genre_description = if genre1.blank?
      genre2
                         elsif genre1 == genre2
      genre1
                         else
      "#{genre1} / #{genre2}"
                         end
  end
end
