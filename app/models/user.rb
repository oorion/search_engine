class User < ActiveRecord::Base
  validates :email, presence: true
  validates :password, presence: true

  def authenticate(test_password)
    password == test_password
  end
end
