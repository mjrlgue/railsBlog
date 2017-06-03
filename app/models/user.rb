class User < ActiveRecord::Base
	#save email in lower_case
	before_save{ self.email=email.downcase }
	validates :name, presence: true, length: {maximum: 50 }
	VALID_EMAIL_REGEX=/\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 255}, format: { with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

	##add password to users when registring
	has_secure_password #this methode gives us two attributes: password, password_confirmation
	validates :password, length: { minimum: 6 }
end
