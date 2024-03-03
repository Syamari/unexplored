class ApplicationController < ActionController::Base
	add_flash_types :success, :info, :warning, :error

	require 'rspotify'
  RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'])
	ENV['ACCEPT_LANGUAGE'] = 'ja'

	require 'openai'

	def get_recommend_genre(genres)
		client = OpenAI::Client.new(access_token: ENV['OPENAI_CLIENT_ID'])
		response = client.chat(
			parameters: {
				model: 'gpt-3.5-turbo',
				messages: [
					{
						role: 'user',
						content: "You are a music recommender AI that handles a wide range of genres. The following array represents a set of music genres preferred by a certain user. Taking into account the granularity, BPM, and dynamics tendencies of the music genres in this array, please guess a popular music genre that is less related to the genres in this array, i.e., a popular music genre that this user has not yet listened to. Output one genre from it as a string in 1-3 words. However, please do not output genres that are too minor or too major. #{genres}"
					}
				]
			}
		)
		response.dig('choices', 0, 'message', 'content')
	end

end
