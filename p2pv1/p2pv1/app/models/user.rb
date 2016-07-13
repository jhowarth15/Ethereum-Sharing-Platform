class User < ActiveRecord::Base

  validates :user_id, :email, :postcode, presence: true

end
