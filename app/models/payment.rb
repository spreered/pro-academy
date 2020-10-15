class Payment < ApplicationRecord
  belongs_to :order

  enum state: {pending: 0, success: 1, failed: 2}
end
