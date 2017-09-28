class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  devise :omniauthable
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
   def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    #data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
    if user
      return user
    else
      registered_user = User.where(:email => access_token.info.email).first
      if registered_user
        return registered_user
       else
      # user = nil
        pwd=Devise.friendly_token[0,20]
          user = User.create(
          # first_name: data["name"],
          provider:access_token.provider,
          email: access_token.info.email,
          uid: access_token.uid ,
          :password => pwd,
          :name => access_token.info.first_name,
          :confirmed_at => Date.today)
          user.save(validate:false)
      return user
      end
    end
  end

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    user = User.where(:provider => access_token.provider, :uid => access_token.uid).first
      if user
      return user
    else
      registered_user = User.where(:email => access_token.info.email).first
      if registered_user
        return registered_user
      else

        #user = nil
        #user_type == "User"
        name= access_token.extra.raw_info.name
        if name.present?
         f_name = name.split(" ")[0]
         l_name = name.split(" ")[1]
        end
        pwd=Devise.friendly_token[0,20]
        user = User.create(:provider => access_token.provider, :uid => access_token.uid,:email => access_token.info.email,:password => pwd, :confirmed_at => Date.today,:name => f_name+l_name)
         #@player = Date.strptime(access_token.extra.raw_info.birthday,'%m/%d/%Y')
        # user.generate_authentication_token!
         user.save(validate:false)
         return user
        # UserMailer.user_registration_mail(user).deliver!
        #sign_in_and_redirect @user, :event => :authentication
    
      end
    end
  end
end
