shared_context :with_api_key do

  let(:api_key) do
    'somekey'
  end

  before do
    NovaPoshta.configure do |c|
      c.api_key = api_key
    end
  end
end