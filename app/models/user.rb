class User

	include Mongoid::Document
	include Mongoid::Timestamps

	attr_accessible :name, :fb_image 

	field :provider
	field :uid
	field :name
	field :oauth_token
	field :fb_image, :type => String
	field :oauth_expires_at, type: DateTime

	has_many :posts
	has_many :images
	# mount_uploader :image, ImageUploader

	def self.from_omniauth(auth)
		where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
			user.provider = auth.provider
			user.uid = auth.uid
			user.name = auth.info.name
			user.fb_image = auth.info.image.split("?")[0] + "?type=large"
			user.oauth_token = auth.credentials.token
			user.oauth_expires_at = Time.at(auth.credentials.expires_at)
			user.save!
		end
	end

	def self.write_post(user_id)
		user = User.find(user_id)
	    @graph = Koala::Facebook::API.new(user.oauth_token)
	    @graph.put_wall_post("Check my new post here!", {
	    	"name" => Post.last.title,
	    	"link" => "http://3wy7.localtunnel.com/post_index", # remember to update this in dev env
	    	"caption" => "#{user.name} posted a new minipost",
	    	"description" => Post.last.content
	    })    
	end

	def facebook
		@facebook ||= Koala::Facebook::API.new(oauth_token)
		block_given? ? yield(@facebook) : @facebook
	rescue Koala::Facebook::APIError => e
	    logger.info e.to_s
	    nil
	end
end
