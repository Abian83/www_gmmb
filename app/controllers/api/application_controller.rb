class Api::ApplicationController < ApplicationController
	before_action :authenticate

	protected
		def authenticate
			#TODO: we have to set a app_token for user creation, other actions use the user_token.
			return true if new_user?  #&& token == Settings.mobile_token
		  authenticate_or_request_with_http_token do |token, options|
		  	session[:token] = token
		    User.find_by(api_token: token)
		  end
		end

		def new_user?
			request.post? && action_name == 'create' && controller_name == "users"
		end
end
