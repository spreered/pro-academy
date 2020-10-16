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
        present courses 
      end

      route_param :id do
        desc 'Buy the course'
        post 'apply' do
          form = ::Orders::CheckoutForm.new(user: current_user, course_id: params[:id])
          if form.save!
            present form.order
          else
            error!(form.errors.full_messages.join(''), 400)
          end
        end
      end
    end 
  end
end
