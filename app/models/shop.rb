class Shop < ApplicationRecord
  belongs_to :organization

  has_many :staffs
  has_many :items
end
