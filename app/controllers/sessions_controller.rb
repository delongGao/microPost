class SessionsController < ApplicationController
	def init
		if current_user
			redirect_to post_index_path  
			# here you need to follow the exact pattern
			# redirect and named_root_path
		else
			root_url
		end
	end

	def create
		user = User.from_omniauth(env["omniauth.auth"])
		session[:user_id] = user.id
		# redirect_to post_index
		redirect_to root_url
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url
	end
end
