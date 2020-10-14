module Courses
  class V1 < Grape::API
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
