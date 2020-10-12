class Admin::CoursesController < Admin::BaseController 
  before_action :find_course, only: [:show, :destroy, :edit, :update]
  def index
    @courses = Course.order(id: :desc).page(params[:page]).per(20).includes(:category)
  end

  def new
    @course = Course.new
  end

  def create 
    @course = Course.new(course_params)
    if @course.save
      redirect_to admin_course_url(@course)
    else
      flash.now[:alert] = "Create course failed, reason: #{@course.errors.full_messages}"
      render :new
    end
  end 

  def show
    @course_root_url = "#{request.base_url}/courses/"
  end

  def destroy
    @course.destroy
    flash[:notice] = "Delete course #{@course.id}: #{@course.title}"

    redirect_to admin_root_url 
  end

  def update
    if @course.update(course_params)
      redirect_to admin_course_url(@course)
    else
      flash.now[:alert] = "Update failed, reason: #{@course.errors.full_messages}"
      render :edit
    end
  end 

  private

  def find_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :category_id, :status, :slug, :duration, :description)
  end
end
