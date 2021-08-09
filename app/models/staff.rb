class Staff < ApplicationRecord
  belongs_to :organization
  # belongs_to :shop

  has_secure_password

  def self.default_scope
    self.select([:id, :username, :role, :organization_id, :shop_id, :created_at, :updated_at])
  end
end
