module CoursesHelper
  def price_with_currency(price)
    "#{humanized_money_with_symbol price} #{price.currency.to_s}"
  end
end
