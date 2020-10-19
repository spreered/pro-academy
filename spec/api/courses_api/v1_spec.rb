require 'rails_helper'
require 'shared/api_shared_example'

describe CoursesAPI::V1 do
  let(:user) { create(:user, :with_valid_access_token) }
  let(:access_token) { user.access_token }
  let(:headers) do 
    { 
      'Content-Type' => 'application/json', 
      'Authorization' => access_token
    }
  end

  before { create(:course) } 
  describe 'get v1/coures' do
    let(:uri) { '/api/v1/courses' }
    before { get uri, headers: headers }
    context 'when without authenticate header' do
      let(:headers) { { 'Content-Type' => 'application/json' } }

      it_behaves_like '401'
    end

    it_behaves_like '200'
    it do
      expect(JSON.parse( response.body ).first).to include({"title"=>"Sample Course",
                                                            "slug"=>"sample-course",
                                                            "category" => "Some Category",
                                                            "description" => "This is Sample Course"})
    end

  end

  describe 'get v1/courses/purchased' do
    let(:uri) { '/api/v1/courses/purchased' }
    before { get uri, headers: headers }
    context 'not login' do
      let(:headers) { { 'Content-Type' => 'application/json' } }

      it_behaves_like '401'
    end

    it_behaves_like '200'

    context 'when user purchased coures' do
      let(:course_1) { create(:course, title: 'Course 1', duration: 1) }
      subject { user.purchased_courses }
      before do
        create(:order, :fulfilled, course: course_1, user: user)
        get uri, headers: headers
      end

      it { expect(body(response).count).to be 1 }
      it { expect(body(response).first['title']).to eq('Course 1') }
      it { expect(body(response).first.keys).to match_array(['title', 'category', 'description', 'slug', 'orders']) }
      it { expect(body(response).first['orders'].count).to be(1) }

      it 'containt history orders of this course' do
        order_info = body(response).first['orders'].first

        expect(body(response).first['orders'].count).to be(1) 
        expect(order_info.keys).to match_array(['order_id', 'order_state', 'amount', 'amount_currency', 'end_at', 'paid_at'])
      end

      context 'when user buy another course' do
        let(:course_2) { create(:course, title: 'Course 2', duration: 7) }
        before do
          create(:order, :fulfilled, course: course_2, user: user)
          get uri, headers: headers
        end 
        it { expect(body(response).count).to be 2 }
        it { expect(body(response).map{|c| c['title']}).to match_array([ 'Course 1', 'Course 2']) }

        context 'when 1 course expired' do
          before do 
            Timecop.travel(Time.zone.now + 2.days) 
            get uri, headers: headers
          end
          after { Timecop.return }
          it { expect(body(response).count).to be 1 }
          it { expect(body(response).map{|c| c['title']}).to match_array(['Course 2']) }
        end
      end
    end
  end

  describe 'post v1/courses/:id/apply' do
    let(:course) { create(:course, title: 'Course 1', duration: 1) }
    let(:course_id) { course.id }
    let(:uri) { "/api/v1/courses/#{course_id}/apply" }
    context 'not login' do
      let(:headers) { { 'Content-Type' => 'application/json' } }
      before { post uri, headers: headers }

      it_behaves_like '401'
    end
    context 'purchase a course' do
      before { post uri, headers: headers }
      it_behaves_like '201'
      it { expect(body(response).keys).to match_array(['order_id', 'course', 'order_state', 'amount', 'amount_currency', 'end_at', 'paid_at'])  }

      context 'purchase course when it still avaliable' do
        before {post uri, headers: headers}
        it_behaves_like '400'
        it { expect(body(response)).to include({"error"=>"Coures has been purchased and still available."}) }
      end
      context 'purchase course when previous is expired' do
        before do
          Timecop.travel(2.days.after)
          post uri, headers: headers
        end
        after { Timecop.return }

        it_behaves_like '201'
        it 'create another order' do
          expect(user.orders.count).to eq 2
        end
      end
    end
  end
  def body(response)
    JSON.parse( response.body )
  end

end
