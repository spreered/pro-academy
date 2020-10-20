class UserCoursesQueryService
  def initialize(user, params = {})
    @user = user
    @available_only = params.fetch(:available_only, false)
    # binding.pry
    @category_name = unescape(params.fetch(:category, nil))
  end

  def perform
    # binding.pry
    @q = base_courses_scope 
    filter_by_category if @category_name.present?

    @q
  end

  private

  def base_courses_scope
    return @user.available_courses if available_only?

    @user.purchased_courses
  end

  def filter_by_category 
    @q = @q.joins(:category).where("categories.name ILIKE ?", @category_name )
  end

  def unescape(str)
    return if str.nil?

    URI.unescape(str)
  end

  def available_only?
    false if @available_only.blank?

    ActiveRecord::Type::Boolean.new.cast(@available_only)
  end
end
