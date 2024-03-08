class ListArtist < ApplicationRecord
  belongs_to :list, touch: true
  belongs_to :artist
end
