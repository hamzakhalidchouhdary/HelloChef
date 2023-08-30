class Organization < ApplicationRecord
  has_many :shops
  has_many :staffs
  has_many :bills
  has_many :orders

  has_one :user
end
