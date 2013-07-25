class PostsController < ApplicationController
	def create
		# @user = User.find(params[:user_id])
		if current_user
			@post = Post.create_post(params[:post], current_user.uid)
			unless current_user.oauth_token.blank?
				User.write_post(current_user.id)
			end
		end
		flash.now[:success] = "Post has been created."
		redirect_to post_index_path
	end

	def index
		if current_user 
			user = User.find(current_user.id)
			@posts = Post.where(p_uid: user.uid)
			@post = Post.new
			@image = Image.new
		else
			redirect_to root_url
		end
	end
end
