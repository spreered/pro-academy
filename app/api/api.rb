class API < Grape::API
  prefix :api
  format :json
  mount Courses::V1
  mount APILogin
end
