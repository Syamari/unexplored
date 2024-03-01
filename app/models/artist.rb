class Artist < ApplicationRecord
	has_many :list_artists, dependent: :destroy
	has_many :lists, through: :list_artists, dependent: :destroy

	has_many :artist_genres, dependent: :destroy
	has_many :genres, through: :artist_genres, dependent: :destroy

	validates :name, presence: true, length: { maximum: 255 }
end
