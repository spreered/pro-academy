class Admin::CoursesController < Admin::BaseController 
  def index
    @courses = Course.page(params[:page]).per(20).includes(:category)
  end

  def show
    @course = Course.find(params[:id])
    @course_root_url = "#{request.base_url}/courses/"
  end
end
