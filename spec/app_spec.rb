# frozen_string_literal: true

require 'rack/test'
require 'rspec'
require_relative '../app'

RSpec.describe RequestDumperApp do # rubocop:disable Metrics/BlockLength
  include Rack::Test::Methods

  def app
    RequestDumperApp
  end

  let(:headers) { { 'HTTP_CUSTOM_HEADER' => 'custom-value' } }

  shared_examples 'request echo response' do |method, path, body = nil|
    it "responds with request info for #{method.upcase} #{path}" do
      send(method, path, body, headers)

      expect(last_response.status).to eq(200)
      expect(last_response.content_type).to include('application/json')

      json = JSON.parse(last_response.body)
      expect(json['path_info']).to eq(URI(path).path)
      expect(json['method']).to eq(method.to_s.upcase)
      expect(json['headers']).to include('HTTP_CUSTOM_HEADER' => 'custom-value')

      if body.is_a?(Hash)
        parsed_params = JSON.parse(json['params'])
        expect(parsed_params).to include(body.transform_keys(&:to_s))
      end
    end
  end

  describe 'GET /*' do
    include_examples 'request echo response', :get, '/get/test?foo=bar'
  end

  describe 'POST /*' do
    include_examples 'request echo response', :post, '/post/test', { key: 'value' }
  end

  describe 'PUT /*' do
    include_examples 'request echo response', :put, '/put/test', { data: '123' }
  end

  describe 'DELETE /*' do
    include_examples 'request echo response', :delete, '/delete/test'
  end

  describe 'OPTIONS /*' do
    include_examples 'request echo response', :options, '/options/test'
  end
end
