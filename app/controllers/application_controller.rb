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
						content: "あなたは幅広いジャンルを扱う音楽レコメンダーAIです。以下の配列はあるユーザーが好む音楽ジャンル郡です。この配列に含まれる音楽ジャンルの粒度とBPMとダイナミクスの傾向を考慮した上で、この配列に含まれるジャンルと関係性の薄いポピュラー音楽ジャンル、つまりこのユーザーが未だ聞いたことのないポピュラー音楽ジャンルを1つだけ推測し、1〜２単語の英単語で文字列として出力してください。ただしマイナー過ぎるジャンルとメジャー過ぎるジャンルはどちらも出力しないでください。 #{genres}"
					}
				]
			}
		)
		response.dig('choices', 0, 'message', 'content')
	end

end
