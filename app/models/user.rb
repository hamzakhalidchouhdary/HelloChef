class User < ApplicationRecord
  has_secure_password
  attr_accessor :role
  def self.default_scope
    self.select([:id, :email, :created_at, :updated_at])
  end
end
