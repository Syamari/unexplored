class ListArtistsController < ApplicationController

	def create
			artist_name = RSpotify::Artist.search(params[:name]).first.name
			artist = Artist.find_or_create_by(name: artist_name)
			@list = List.find(params[:list_id])
			@list.artists << artist unless @list.artists.include?(artist)
			redirect_to @list
	end

	def destroy
			@list = List.find(params[:list_id])
			artist = Artist.find(params[:id])
			@list.artists.delete(artist)
			redirect_to @list
	end

	private

	def list_params
		params.require(:list_artist).permit(:artist_name)
	end
end
