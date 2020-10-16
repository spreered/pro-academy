class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_secure_token :access_token

  has_many :orders
  has_many :course_available_orders, ->{ course_available }, class_name: 'Order'
  has_many :available_courses, through: :course_available_orders, source: :course

  enum role: { normal: 0, admin: 1 }

  def self.verify(access_token)
    return if access_token.blank?

    user = User.find_by(access_token: access_token)
    user.try(:access_token_expired?) ? nil : user
  end


  def renew_access_token!
    regenerate_access_token
    update(access_token_expired_at: DateTime.now + 1.day)

    access_token
  end 

  def access_token_expired?
    return true if access_token_expired_at.nil?

    access_token_expired_at < DateTime.now
  end
end
