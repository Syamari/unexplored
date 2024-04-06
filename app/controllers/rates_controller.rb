class RatesController < ApplicationController
  def index
    @rates = Rate.where(user_id: current_user.id).order(created_at: :desc)
  end

  def show
    @rate = Rate.find(params[:id])
    song_name = @rate.song.name
    artist_name = @rate.song.artist.name
    @selected_song = RSpotify::Track.search("#{artist_name} #{song_name}").first
    url = @selected_song.embed.match(%r{https://embed\.spotify\.com/\?uri=spotify:track:(\w+)})
    @player_url = "https://open.spotify.com/embed/track/#{url[1]}"
  end

  def update
    @rate = Rate.find(params[:id])
    unless @rate.update(rate_params)
      redirect_to rates_path
      flash[:info] = 'レーティングの更新に失敗しました'
    end
  end

  private

  def rate_params
    params.require(:rate).permit(:score)
  end
end
