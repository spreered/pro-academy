RSpec.shared_examples '400' do
  it 'returns 400' do
    expect(response.status).to eq(400)
  end
end

RSpec.shared_examples '401' do
  it 'returns 401' do
    expect(response.status).to eq(401)
  end
end

RSpec.shared_examples '200' do
  it 'returns 200' do
    expect(response.status).to eq(200)
  end
end

