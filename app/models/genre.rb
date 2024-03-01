class Genre < ApplicationRecord
  has_many :artist_genres, dependent: :destroy
  has_many :artists, through: :artist_genres, dependent: :destroy

	validates :name, presence: true, length: { maximum: 255 }
end
