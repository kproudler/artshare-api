class Artwork < ApplicationRecord
    validates :title, presence: true
    validates :title, uniqueness: { scope: :artist_id }
    validates :favorite, inclusion: { in: [true, false] }

    has_one_attached :picture, dependent: :destroy

    has_many :artwork_shares

    has_many :comments, dependent: :destroy

    belongs_to :artist,
        foreign_key: :artist_id,
        class_name: 'User'

    has_many :likes,
        as: :likeable
    
    def self.artworks_for_user_id(user_id)
        Artwork
            .left_outer_joins(:artwork_shares)
            .where('(artworks.artist_id = :user_id) OR (artwork_shares.viewer_id = :user_id)', user_id: user_id)
            .distinct
    end


end