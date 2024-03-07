module ApplicationHelper

	def get_unique_genre_names(list)
		artists = list.artists
		all_genre_names = artists.map { |artist| artist.genres.limit(6).map(&:name) }.flatten
		unique_genre_names = all_genre_names.uniq
		unique_genre_names
	end

end
