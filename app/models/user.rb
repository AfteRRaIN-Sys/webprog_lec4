class User < ApplicationRecord

	has_many :posts

	validates :email, presence: true, uniqueness: true
	#validates :pass, presence: true, length: {minimum: 1}
	#validates :name, length: {minimum: 2}

	#errors go to u.errors(activeerror, array)
	#errors << ["adasdasdad"]
	
	has_secure_password
end
