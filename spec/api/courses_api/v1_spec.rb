require 'rails_helper'

describe CoursesAPI::V1 do
  let(:user) { create(:user, :with_valid_access_token) }
  let(:access_token) { user.access_token }
  let(:headers) do 
    { 
      'Content-Type' => 'application/json', 
      'Authorization' => access_token
    }
  end

  before do
    create(:course)
  end
  describe 'get v1/coures' do
    it do
      get '/api/v1/courses', headers: headers
      expect(JSON.parse( response.body ).first).to include({"title"=>"Sample Course",
                                                            "slug"=>"sample-course",
                                                            "category" => "Some Category",
                                                            "description" => "This is Sample Course"})
    end
  end

  describe 'get v1/coures/purchased' do
    # @todo
  end

  describe 'post v1/courses/:id/apply' do
    # @todo
  end
end
