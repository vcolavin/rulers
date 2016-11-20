require 'spec_helper'
include Rack::Test::Methods

describe Rulers do
  it 'has a version number' do
    expect(Rulers::VERSION).not_to be nil
  end

  it 'can do a get request' do
    get '/'
    expect(last_response.status).to eq(200)
  end
end
