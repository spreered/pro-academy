class Course < ApplicationRecord
  belongs_to :category
  enum status: {delisted: 0, launched: 1}
end
