require 'spec_helper'

describe 'getWarehouses' do

  let(:model) do
    NovaPoshta::Model::Address.new
  end

  # method args
  let(:params) do
    {}
  end

  # requested methodProperties
  let(:method_properties) do
    {CityRef: city_ref}
  end

  let(:city_ref) do
    '8e1718f5-1972-11e5-add9-005056887b8d'
  end

  subject do
    model.warehouses(city_ref, params)
  end

  include_context :with_api_key

  before do
    WebMock.stub_request(:post, NovaPoshta::Api::API_URL).
        with(body: {
            apiKey: api_key,
            modelName: 'Address',
            calledMethod: 'getWarehouses',
            methodProperties: method_properties
        }.to_json).
        to_return(status: 200, body: read_fixture_file('get_warehouses.json'))
  end

  it 'should return 1 cities' do # look at fixture
    expect(subject.count).to eq(1)
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

  it 'response should be success' do
    expect(subject.success?).to eq(true)
  end

  it 'response should be an instance of NovaPoshta::Result' do
    expect(subject).to be_instance_of(NovaPoshta::Result)
  end

  context 'city method of warehouse' do

    let(:warehouse) do
      NovaPoshta::Response::Warehouse.new(city_ref: "8e1718f5-1972-11e5-add9-005056887b8d")
    end

    it 'should responds on city method' do
      expect(warehouse).to respond_to(:city)
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
      warehouse.city
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