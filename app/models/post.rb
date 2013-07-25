class Post
	include Mongoid::Document
	include Mongoid::Timestamps

	field :title
	field :content
	field :p_uid
	belongs_to :user
	attr_accessible :title, :content

	validates_presence_of :title, :content

  	def self.create_post(params, uid)
		# where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
		# 	user.provider = auth.provider
		# 	user.uid = auth.uid
		# 	user.name = auth.info.name
		# 	user.fb_image = auth.info.image.split("?")[0] + "?type=large"
		# 	user.oauth_token = auth.credentials.token
		# 	user.oauth_expires_at = Time.at(auth.credentials.expires_at)
		# 	user.save!
		# end

		post = Post.new
		post.title = params[:title]
		post.content = params[:content]
		post.p_uid = uid
		post.save!
		if post.save
			return true
		else
			return false
		end
	end

end
