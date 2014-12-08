class User < ActiveRecord::Base
	# 所有
	has_many :week_reports, dependent: :destroy
	has_many :projects, through: :week_reports
	#　所属
	belongs_to :user_group, class_name: "Group"
	# 事前実行メソッド
	before_create :create_remember_token
	# has_secure_password
	has_secure_password
	# 検証
	validates :password, length: { minimum: 1 }, confirmation: true, on: :create
	#メソッド
	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end
	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end
	def user_id_and_name
		self.worker_num.to_s + ' : ' + self.name
	end
	private
		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end
end
