class User < ApplicationRecord
	validates :email, presence: true
	validates :pass, presence: true, length: {minimum: 1}
	#validates :name, length: {minimum: 2}

	#errors go to u.errors(activeerror, array)
	#errors << ["adasdasdad"]

end
