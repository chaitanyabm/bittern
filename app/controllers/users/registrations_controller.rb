class Users::RegistrationsController < Devise::RegistrationsController
  # Override the action you want here.
  
  def new
    @user_type = params[:user_type]
    super
  end

	def create
		if params[:user][:phone_number].present?
		@user = User.create(phone_number: params[:user][:phone_number])
		@user.generate_pin
    	@user.send_pin
    	respond_to do |format|
    	format.js # render app/views/phone_numbers/create.js.erb
    	end
    	end
    else
    	super
	end


end
