class User < ApplicationRecord
    attr_reader :password
    validates :username, :password_digest, :session_token, presence: true
    validates :username, uniqueness: true, presence: true
    validates :password, length: { minimum: 6, allow_nil: true }

    has_many :artworks,
        foreign_key: :artist_id,
        dependent: :destroy
    
    has_many :shared_artworks,
        through: :artwork_shares,
        source: :artwork

    has_many :comments, dependent: :destroy
end
