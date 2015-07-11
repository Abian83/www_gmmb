class Api::ApplicationController < ApplicationController
	before_action :authenticate

	protected
		def authenticate
		  authenticate_or_request_with_http_token do |token, options|
		  	return true if new_user?
		  	session[:token] = token
		    User.find_by(api_token: token)
		  end
		end

		def new_user?
			request.post? && action_name == 'create' && controller_name == "users"
		end
end
