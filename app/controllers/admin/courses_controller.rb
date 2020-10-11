class Admin::CoursesController < Admin::BaseController 
  def index
    @courses = Course.page(params[:page]).per(20).includes(:category)
  end
end
