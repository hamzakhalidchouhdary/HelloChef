class Organization < ApplicationRecord
  has_many :shops
  has_many :staffs
  has_one :user
end
