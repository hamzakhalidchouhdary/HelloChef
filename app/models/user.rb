class User < ApplicationRecord
  belongs_to :organization
  has_secure_password
  attr_accessor :role
  # def self.default_scope
  #   self.select([:id, :username, :created_at, :updated_at, :organization_id])
  # end
end
