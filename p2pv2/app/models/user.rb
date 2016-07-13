class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
	 :confirmable, :lockable

  has_many :items

  # Set all emails to lowercase before saving to the database
  before_save { self.email = email.downcase }

  # BEGIN User entries in the database MUST have these entries valid

  validates(:username, presence: true, length: { maximum: 25 }, uniqueness: true)
  validates(:name_first, presence: true, length: { maximum: 50 })
  validates(:name_last, presence: true, length: { maximum: 50 })
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
			format: { with: VALID_EMAIL_REGEX }, 
			uniqueness: { case_sensitive: false }
  # END User entries in the database MUST have these entries valid

end
