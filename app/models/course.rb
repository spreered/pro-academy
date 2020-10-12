class Course < ApplicationRecord
  belongs_to :category
  validates :title, :slug, presence: true, uniqueness: { case_sensitive: false, message: 'has been taken'}
  validates :duration, inclusion: { in: (1..31) } 
  enum status: {delisted: 0, launched: 1}
end
