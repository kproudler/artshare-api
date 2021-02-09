class User < ApplicationRecord
    attr_reader :password
    validates :username, :session_token, presence: true
    validates :password_digest, presence: { message: 'Password can\'t be blank' }
    validates :username, uniqueness: true, presence: true
    validates :password, length: { minimum: 6, allow_nil: true }
    after_initialize :ensure_session_token

    has_many :artworks,
        foreign_key: :artist_id,
        dependent: :destroy
    
    has_many :shared_artworks,
        through: :artwork_shares,
        source: :artwork

    has_many :comments, dependent: :destroy

    has_many :likes

    has_many :liked_comments,
        through: :likes,
        source: :likeable,
        source_type: 'Comment'
    
    has_many :liked_artworks,
        through: :likes,
        source: :likeable,
        source_type: 'Artwork'

    before_validation :ensure_session_token

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)

        # no user with given username
        return nil if user.nil?

        # check user's password
        user.is_password?(password) ? user : nil
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def self.generate_session_token
        SecureRandom::urlsafe_base64(16)
    end

    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save!
    end

    private

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end
end
