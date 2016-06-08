require 'spec_helper'

describe 'getAreas' do

  let(:model) do
    NovaPoshta::Model::Address.new
  end

  # method args
  let(:params) do
    {}
  end

  # requested methodProperties
  let(:method_properties) do
    {}
  end

  subject do
    model.areas(params)
  end

  include_context :with_api_key

  before do
    WebMock.stub_request(:post, NovaPoshta::Api::API_URL).
        with(body: {
            apiKey: api_key,
            modelName: 'Address',
            calledMethod: 'getAreas',
            methodProperties: method_properties
        }.to_json).
        to_return(status: 200, body: read_fixture_file('get_areas.json'))
  end

  it 'should return 25 areas' do # look at fixture
    expect(subject.count).to eq(25)
  end

  it 'check area attributes' do # look at fixture
    area = subject.first

    expect(area.description).to eq('АРК')
    expect(area.ref).to eq('71508128-9b87-11de-822f-000c2965ae0e')
    expect(area.areas_center).to eq('db5c88b7-391c-11dd-90d9-001a92567626')

  end

  it 'response should be success' do
    expect(subject.success?).to eq(true)
  end

  it 'response should be an instance of NovaPoshta::Result' do
    expect(subject).to be_instance_of(NovaPoshta::Result)
  end

  context 'cities method of area' do

    let(:area) do
      NovaPoshta::Response::Area.new(ref: "71508136-9b87-11de-822f-000c2965ae0e")
    end

    it 'should responds on cities method' do
      expect(area).to respond_to(:cities)
    end

    before do
      WebMock.stub_request(:post, NovaPoshta::Api::API_URL).
          with(body: {
              apiKey: api_key,
              modelName: 'Address',
              calledMethod: 'getCities',
              methodProperties: {}
          }.to_json).
          to_return(status: 200, body: read_fixture_file('get_cities.json'))
    end

    subject do
      area.cities
    end

    it 'response should be an instance of NovaPoshta::Result' do
      expect(subject).to be_instance_of(NovaPoshta::Result)
    end

    it 'response should be success' do
      expect(subject.success?).to eq(true)
    end

    it 'check city attributes' do # look at fixture
      city = subject.first

      expect(city.description).to eq('Авангард')
      expect(city.description_ru).to eq('Авангард')
      expect(city.ref).to eq('8e1718f5-1972-11e5-add9-005056887b8d')
      expect(city.area_ref).to eq('71508136-9b87-11de-822f-000c2965ae0e')
    end


  end

end