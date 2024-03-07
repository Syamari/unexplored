class ListArtistsController < ApplicationController
	before_action :require_login
	before_action :set_list

	def create
		if params[:name].blank?
			flash[:error] = 'アーティスト名が入力されていません'
			redirect_to @list
			return
		end
	
		begin
			searched_artist = RSpotify::Artist.search(params[:name])
		rescue RestClient::BadRequest => e
			flash[:info] = 'アーティスト名の取得に失敗しました'
			redirect_to @list
			return
		end
	
		if searched_artist.empty?
			flash[:info] = 'そのアーティストは取得できませんでした'
			redirect_to @list
			return
		end

		artist_name = searched_artist.first.name
		artist = Artist.find_or_create_by(name: artist_name)
		@list.artists << artist unless @list.artists.include?(artist)
		artist_genres = RSpotify::Artist.search(params[:name]).first.genres
		genres = artist_genres.map do |artist_genre|
			genre = Genre.find_or_create_by(name: artist_genre)
			artist.genres << genre unless artist.genres.include?(genre)
		end
		
		redirect_to @list
	end

	def destroy
			artist = Artist.find(params[:id])
			@list.artists.delete(artist)
			redirect_to @list
	end

	private

	def set_list
		@list = List.find(params[:list_id])
	end

	def list_params
		params.require(:list_artist).permit(:artist_name)
	end
end
