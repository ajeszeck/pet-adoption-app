require 'bcrypt'

class User < ApplicationRecord
  include BCrypt

  has_secure_password
end
