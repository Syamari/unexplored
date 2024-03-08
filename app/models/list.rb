class List < ApplicationRecord
	belongs_to :user
	has_many :list_artists, dependent: :destroy
	has_many :artists, through: :list_artists, dependent: :destroy

	validates :name, presence: true, length: { maximum: 255 }	
end