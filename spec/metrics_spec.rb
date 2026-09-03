# frozen_string_literal: true

require 'rack/test'
require 'rspec'
require 'rack'

RSpec.describe 'Prometheus metrics' do
  include Rack::Test::Methods

  def app
    Rack::Builder.parse_file(File.expand_path('../config.ru', __dir__))
  end

  it 'reports the application as online' do
    get '/metrics'

    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('online_flag{name="my_site"} 1.0')
  end
end
