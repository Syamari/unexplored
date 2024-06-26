module ApplicationHelper

  def get_unique_genre_names(list)
    artists = list.artists
    all_genre_names = artists.map { |artist| artist.genres.limit(6).map(&:name) }.flatten
    unique_genre_names = all_genre_names.uniq
    unique_genre_names
  end

  def get_related_artists_names(list)
    artist_names = list.artists.sample(3).map(&:name) # 発火の都度ランダムに取得
    related_artists_names = []
    artist_names.each do |name|
      related_artists = RSpotify::Artist.search(name).first.related_artists.first(4) # 関連アーティストをまず4人取得
      related_artists_names += related_artists.sample(2).map(&:name) # そこから2人だけ配列に追加(4C2)
    end
    related_artists_names
  end

  def default_meta_tags
    {
      site: 'Unexplored Music',
      title: 'まだ知らない音楽ジャンルを見つけるための音楽レコメンドAIサービス',
      reverse: true,
      charset: 'utf-8',
      description: 'Unexplored Music はユーザーがまだ知らないジャンルを推定して 新鮮な音楽体験を提供する、 AI を使った音楽レコメンドサービスです。',
      keywords: '音楽,ジャンル,楽曲',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('card5.jpg'),
        local: 'ja-JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@SyamariTech',
        image: image_url('card5.jpg')
      }
    }
  end
end
