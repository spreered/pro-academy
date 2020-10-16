class API < Grape::API
  prefix :api
  format :json
  mount CoursesAPI::V1
  mount APILogin
end
