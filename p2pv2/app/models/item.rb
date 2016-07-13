class Item < ActiveRecord::Base

  belongs_to :user
  validates :user, presence: true

  # BEGIN Item entries in the database MUST have these entries valid
  validates :name, presence: true, length: { maximum: 255 }
  validates :location, presence: true, length: { maximum: 50 }

  geocoded_by :full_street_address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

  def self.search(search)            # find the items that contain the search word in their name, category or model
    where("lower(name || category || model) LIKE ?", "%#{search.downcase}%")
  end

  def address                       # return location of the item as address
    "#{location}"
  end

  def full_street_address
    "#{location}"
  end
end
