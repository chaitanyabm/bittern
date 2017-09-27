class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         has_many :posts

    def generate_pin
  		self.pin = rand(0000..9999).to_s.rjust(4, "0")
  		save
	end

	def twilio_client
  		Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_TOKEN'])
	end

	def send_pin
  		twilio_client.messages.create(
    	to: '+919902498853',
    	from: ENV['TWILIO_PHONE_NO'],
    	body: "Your PIN is #{pin}"
  		)
	end
end
