class SongsController < ApplicationController
  include ApplicationHelper

  def show
    @list = List.find(params[:list_id])
    @unique_genres = get_unique_genre_names(@list)
    embed_url = RSpotify::Playlist.search(@unique_genres.first).first.tracks.first.embed
    url = embed_url.match(/https:\/\/embed\.spotify\.com\/\?uri=spotify:track:(\w+)/)
    @song = "https://open.spotify.com/embed/track/#{url[1]}"
  end

end