class Staff < ApplicationRecord
  has_secure_password
  def self.default_scope
    self.select([:id, :email, :role, :created_at, :updated_at])
  end
end
