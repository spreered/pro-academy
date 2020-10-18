module CoursesAPI
  class V1 < Grape::API
    helpers ::APIHelper::AuthenticationHelper
    before { authenticate! }
    version 'v1', using: :path

    resource :courses do
      format :json
      desc 'Get all courses'
      get do
        courses = Course.all
        present courses, with: Entities::CourseEntity
      end

      format :json
      desc 'List courses purchased by user'
      get 'purchased' do
        courses = current_user.available_courses.includes(:category, :orders)
        present courses, with: Entities::UserCourseEntity, user: current_user
      end

      route_param :id do
        desc 'Buy the course'
        post 'apply' do
          form = ::Orders::CheckoutForm.new(user: current_user, course_id: params[:id])
          if form.save!
            present form.order, with: Entities::OrderEntity
          else
            error!(form.errors.full_messages.join(''), 400)
          end
        end
      end
    end 
  end
end
