# frozen_string_literal: true

require 'json'
require 'sinatra/base'
require './repository/request_repository'
require './service/request_service'
require './controller/request_controller'

# Main app
class RequestDumperApp < Sinatra::Base
  set :bind, '0.0.0.0'

  configure :production, :development do
    set :host_authorization, { permitted_hosts: [] }
    enable :logging
  end

  configure :development, :test do
    set :show_exceptions, :after_handler
  end

  error JSON::ParserError do
    content_type :json
    status 400
    { error: 'Invalid JSON request body' }.to_json
  end

  get '/*' do
    content_type :json
    echo_request
  end

  post '/*' do
    content_type :json
    echo_request
  end

  put '/*' do
    content_type :json
    echo_request
  end

  delete '/*' do
    content_type :json
    echo_request
  end

  options '/*' do
    content_type :json
    echo_request
  end

  private

  def echo_request
    repository = RequestRepository.new(request)
    service = RequestService.new(repository, logger)
    RequestController.new(service).echo
  end
end
