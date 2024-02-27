class ListArtist < ApplicationRecord
  belongs_to :list
  belongs_to :artist
end
