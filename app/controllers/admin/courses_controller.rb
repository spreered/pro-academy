class Admin::CoursesController < Admin::BaseController 
  before_action :find_course, only: [:show, :destroy, :edit, :update]
  def index
    @courses = Course.order(id: :asc).page(params[:page]).per(20).includes(:category)
  end

  def show
    @course_root_url = "#{request.base_url}/courses/"
  end

  def destroy
    @course.destroy
    flash[:notice] = "Delete course #{@course.id}: #{@course.title}"

    redirect_to admin_root_url 
  end

  private

  def find_course
    @course = Course.find(params[:id])
  end
end
