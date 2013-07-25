class ImagesController < ApplicationController
	def create
		if current_user 
			user = current_user
			@image = Image.create_image(params[:image], user.uid)
			unless !@image
				redirect_to post_index_path, notice: "Successfully updated user profile."
			else
				redirect_to post_index_path, notice: "Error occured, please try it again."
			end
		end
	end

	def reset
		if current_user && !Image.where(user_uid: current_user.uid).empty?
			Image.where(user_uid: current_user.uid).delete
			redirect_to post_index_path, notice: "Successfully reset image."
		else
			redirect_to post_index_path, notice: "No other images found, use original one."
		end
	end
end