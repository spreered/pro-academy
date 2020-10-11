class Admin::CoursesController < Admin::BaseController 
  def index
    @courses = Course.all.includes(:category)
  end
end
