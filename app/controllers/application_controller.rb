class ApplicationController < ActionController::Base
	add_flash_types :success, :info, :warning, :error

	require 'rspotify'
  RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'])
	ENV['ACCEPT_LANGUAGE'] = 'ja'
end
