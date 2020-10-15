class Order < ApplicationRecord
  belongs_to :user
  belongs_to :course

  enum state: {been_placed: 0, paid: 1, fufilled: 2, cancelled: 3}
end
