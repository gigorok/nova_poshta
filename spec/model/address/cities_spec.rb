require 'spec_helper'

describe 'getCities' do

  let(:model) do
    NovaPoshta::Model::Address.new
  end

  # cities method args
  let(:params) do
    {}
  end

  # requested methodProperties
  let(:method_properties) do
    {}
  end

  subject do
    model.cities(params)
  end

  include_context :with_api_key

  before do
    WebMock.stub_request(:post, NovaPoshta::Api::API_URL).
        with(body: {
            apiKey: api_key,
            modelName: 'Address',
            calledMethod: 'getCities',
            methodProperties: method_properties
        }.to_json).
        to_return(status: 200, body: read_fixture_file('get_cities.json'))
  end

  it 'should return 3 cities' do # look at fixture
    expect(subject.count).to eq(3)
  end

  it 'check city attributes' do # look at fixture
    city = subject.first

    expect(city.description).to eq('Авангард')
    expect(city.description_ru).to eq('Авангард')
    expect(city.ref).to eq('8e1718f5-1972-11e5-add9-005056887b8d')
    expect(city.area_ref).to eq('71508136-9b87-11de-822f-000c2965ae0e')
  end

  it 'response should be success' do
    expect(subject.success?).to eq(true)
  end

  context 'filtering by city_name' do
    let(:method_properties) do
      {FindByString: 'Авангард'}
    end

    let(:params) do
      {find_by_string: 'Авангард'}
    end

    it 'should be built right request' do
      expect_any_instance_of(NovaPoshta::Api).to receive(:post).with({
                                                                         apiKey: api_key,
                                                                         modelName: 'Address',
                                                                         calledMethod: 'getCities',
                                                                         methodProperties: method_properties
                                                                     }.to_json).and_call_original

      subject
    end
  end

  it 'response should be an instance of NovaPoshta::Result' do
    expect(subject).to be_instance_of(NovaPoshta::Result)
  end

  context 'warehouses method of city' do

    let(:city) do
      NovaPoshta::Response::City.new({
                                         "Description" => "Авангард",
                                         "DescriptionRu" => "Авангард",
                                         "Ref" => "8e1718f5-1972-11e5-add9-005056887b8d",
                                         "Delivery1" => "1",
                                         "Delivery2" => "1",
                                         "Delivery3" => "1",
                                         "Delivery4" => "1",
                                         "Delivery5" => "1",
                                         "Delivery6" => "0",
                                         "Delivery7" => "0",
                                         "Area" => "71508136-9b87-11de-822f-000c2965ae0e",
                                         "Conglomerates" => nil,
                                         "CityID" => "1042"
                                     })
    end

    it 'should responds on warehouses method' do
      expect(city).to respond_to(:warehouses)
    end

    before do
      WebMock.stub_request(:post, NovaPoshta::Api::API_URL).
          with(body: {
              apiKey: api_key,
              modelName: 'Address',
              calledMethod: 'getWarehouses',
              methodProperties: {
                  CityRef: '8e1718f5-1972-11e5-add9-005056887b8d'
              }
          }.to_json).
          to_return(status: 200, body: read_fixture_file('get_warehouses.json'))
    end

    subject do
      city.warehouses
    end

    it 'response should be an instance of NovaPoshta::Result' do
      expect(subject).to be_instance_of(NovaPoshta::Result)
    end

    it 'response should be success' do
      expect(subject.success?).to eq(true)
    end

    it 'check warehouse attributes' do # look at fixture
      warehouse = subject.first

      expect(warehouse.description).to eq('Відділення № 1: вул. Абрикосова, 1')
      expect(warehouse.description_ru).to eq('Отделение № 1: ул. Абрикосовая, 1')
      expect(warehouse.phone).to eq('0-800-500-609')
      expect(warehouse.type_of_warehouse).to eq('9a68df70-0267-42a8-bb5c-37f427e36ee4')
      expect(warehouse.ref).to eq('4ecddea5-1986-11e5-add9-005056887b8d')
      expect(warehouse.number).to eq('1')
      expect(warehouse.city_ref).to eq('8e1718f5-1972-11e5-add9-005056887b8d')
      expect(warehouse.max_weight_allowed).to eq(nil)
      expect(warehouse.longitude).to eq('30.616768000000000')
      expect(warehouse.latitude).to eq('46.475177000000000')
      expect(warehouse.reception).to eq({
                                            "Monday" => "10:30-18:00",
                                            "Tuesday" => "10:30-18:00",
                                            "Wednesday" => "10:30-18:00",
                                            "Thursday" => "10:30-18:00",
                                            "Friday" => "10:30-18:00",
                                            "Saturday" => "-",
                                            "Sunday" => "-"
                                        })
      expect(warehouse.delivery).to eq({
                                           "Monday" => "09:00-16:45",
                                           "Tuesday" => "09:00-16:45",
                                           "Wednesday" => "09:00-16:45",
                                           "Thursday" => "09:00-16:45",
                                           "Friday" => "09:00-16:45",
                                           "Saturday" => "09:00-16:00",
                                           "Sunday" => "-"
                                       })
      expect(warehouse.schedule).to eq({
                                           "Monday" => "09:00-18:00",
                                           "Tuesday" => "09:00-18:00",
                                           "Wednesday" => "09:00-18:00",
                                           "Thursday" => "09:00-18:00",
                                           "Friday" => "09:00-18:00",
                                           "Saturday" => "09:00-16:00",
                                           "Sunday" => "-"
                                       })
      expect(warehouse.site_key).to eq('11738')
      expect(warehouse.city_description).to eq('Авангард')
      expect(warehouse.city_description_ru).to eq('Авангард')
      expect(warehouse.post_finance).to eq('1')
      expect(warehouse.pos_terminal).to eq('0')
      expect(warehouse.total_max_weight_allowed).to eq(0)
      expect(warehouse.place_max_weight_allowed).to eq(0)
    end

  end


  context 'area method of city' do

    let(:city) do
      NovaPoshta::Response::City.new(area_ref: '71508136-9b87-11de-822f-000c2965ae0e')
    end

    it 'should responds on area method' do
      expect(city).to respond_to(:area)
    end

    before do
      WebMock.stub_request(:post, NovaPoshta::Api::API_URL).
          with(body: {
              apiKey: api_key,
              modelName: 'Address',
              calledMethod: 'getAreas',
              methodProperties: {}
          }.to_json).
          to_return(status: 200, body: read_fixture_file('get_areas.json'))
    end

    subject do
      city.area
    end

    it 'response should be an instance of NovaPoshta::Result' do
      expect(subject).to be_instance_of(NovaPoshta::Result)
    end

    it 'response should be success' do
      expect(subject.success?).to eq(true)
    end

    it 'check city attributes' do # look at fixture
      area = subject.first

      expect(area.description).to eq('АРК')
      expect(area.ref).to eq('71508128-9b87-11de-822f-000c2965ae0e')
      expect(area.areas_center).to eq('db5c88b7-391c-11dd-90d9-001a92567626')

    end

  end


end