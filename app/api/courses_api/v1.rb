module CoursesAPI
  class V1 < Grape::API
    helpers ::APIHelper::AuthenticationHelper
    before { authenticate! }
    format :json
    version 'v1', using: :path

    resource :courses do
      desc 'Get all courses'
      get do
        courses = Course.all
        present courses 
      end
    end 
  end
end
