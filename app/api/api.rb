class API < Grape::API
  prefix :api
  format :json
  mount Courses::Base
end
