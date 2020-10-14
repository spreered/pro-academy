require 'rails_helper'

describe Courses::V1 do
  before do
    create(:course)

    headers = { 'Content-Type' => 'application/json' }
  end
  describe 'get v1/coures' do
    it do
      get '/api/v1/courses'
      expect(JSON.parse( response.body ).first).to include({"title"=>"Sample Course",
                                                            "status"=>"delisted",
                                                            "slug"=>"sample-course",
                                                            "duration"=>7})
    end
  end
end
