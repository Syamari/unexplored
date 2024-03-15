module ApplicationHelper

	def get_unique_genre_names(list)
		artists = list.artists
		all_genre_names = artists.map { |artist| artist.genres.limit(6).map(&:name) }.flatten
		unique_genre_names = all_genre_names.uniq
		unique_genre_names
	end

	def default_meta_tags
    {
      site: 'Unexplored Music',
      title: '新ジャンル開拓のための音楽レコメンドサービス',
      reverse: true,
      charset: 'utf-8',
      description: 'Unexplored Musicは未知の音楽ジャンルのレコメンドを体験できるサービスです。',
      keywords: '音楽,ジャンル,楽曲',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('card3.jpg'), # 配置するパスやファイル名によって変更すること
        local: 'ja-JP'
      },
      # Twitter用の設定を個別で設定する
      twitter: {
        card: 'summary_large_image', # Twitterで表示する場合は大きいカードにする
        site: '@SyamariTech', # アプリの公式Twitterアカウントがあれば、アカウント名を書く
        image: image_url('card3.jpg') # 配置するパスやファイル名によって変更すること
      }
    }
  end
end
