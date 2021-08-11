class Order < ApplicationRecord
  belongs_to :shop
  belongs_to :organization
  belongs_to :staff
end
