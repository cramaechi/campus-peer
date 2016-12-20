class User < ActiveRecord::Base
  belongs_to :campus
  has_many :sell_book_items
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :confirmable, :validatable

  attr_accessor :campus_name
  #attr_accessible :email, :email_confirmation, :password, :remember_me, :firstname, :lastname, :campus_id, :campus_name

  validates :firstname, :lastname, :email_confirmation, presence: true
  validates :email, :confirmation => true
  validates :campus_id, :presence => { :message => "must be valid" }

	def campus_name
  	"#{campus.name}, #{campus.city}, #{campus.state}" if campus
  end

  def campus_name=(name)
  	parts = name.split(', ')
  	name = parts[0..-3].join(', ')
  	city = parts[-2]
  	state = parts[-1]
  	self.campus = Campus.where("name = ? AND city = ? AND state = ?", name, city, state).first unless name.blank?
  end

end
