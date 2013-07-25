class Image
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessible :user_uid, :image

  field :image
  field :user_uid

  belongs_to :user
  mount_uploader :image, ImageUploader

  	def self.create_image(params, uid)
		# where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
		# 	user.provider = auth.provider
		# 	user.uid = auth.uid
		# 	user.name = auth.info.name
		# 	user.fb_image = auth.info.image.split("?")[0] + "?type=large"
		# 	user.oauth_token = auth.credentials.token
		# 	user.oauth_expires_at = Time.at(auth.credentials.expires_at)
		# 	user.save!
		# end

		image = Image.new
		image.image = params[:image]
		image.user_uid = uid
		image.save!
		if image.save
			return true
		else
			return false
		end
	end
end
