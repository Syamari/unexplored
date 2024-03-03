class SongsController < ApplicationController
  include ApplicationHelper

  before_action :set_list


  def show
    @unique_genres = get_unique_genre_names(@list)
    @recommend_genre = get_recommend_genre(@unique_genres)
    searched_playlists = RSpotify::Playlist.search(@recommend_genre)

    if searched_playlists.empty?
			flash[:info] = 'レコメンドの生成に失敗しました'
			redirect_to @list
			return
		end

    selected_song = searched_playlists.first(4).max_by { |playlist| playlist.followers['total'] }.tracks.sample
    url = selected_song.embed.match(/https:\/\/embed\.spotify\.com\/\?uri=spotify:track:(\w+)/)
    @player_url = "https://open.spotify.com/embed/track/#{url[1]}"
  end

  private

	def set_list
		@list = List.find(params[:list_id])
	end

  private


end