require 'securerandom'
class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy
  attr_accessor :remember_token #have access to the token
    #save email in lower_case
    before_save{ self.email=email.downcase }
    validates :name, presence: true, length: {maximum: 50 }
    VALID_EMAIL_REGEX=/\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum: 255}, format: { with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

    ##add password to users when registring
    has_secure_password #this methode gives us two attributes: password, password_confirmation
    validates :password, length: { minimum: 6 }, allow_blank: true

    def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                                             BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    #returns a random token.
    def User.new_token
      SecureRandom.urlsafe_base64
    end

    #remembers a user in the database to use it in sessions
    def remember
      self.remember_token = User.new_token
      update_attribute(:remember_digest, User.digest(remember_token))
    end

  #forget a user
    def forget
      update_attribute(:remember_digest, nil)
    end

    #returns true if the given token matches the digest
    def authenticated?(remember_token)
      return false if remember_digest.nil?
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    #define a proto-feed
    #see "following users" for the full implementation
    def feed
      Micropost.where("user_id = ?", id)
    end

    
end
