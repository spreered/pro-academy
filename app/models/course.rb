class Course < ApplicationRecord
  CURRENCIES = Rails.configuration.supported_currencies
  belongs_to :category
  has_many :orders

  validates :title, :slug, presence: true, uniqueness: { case_sensitive: false, message: 'has been taken'}
  validates :duration, inclusion: { in: (1..31) } 
  validates :price_currency, inclusion: { in: CURRENCIES }

  enum status: {delisted: 0, launched: 1}

  monetize :price_cents

end
