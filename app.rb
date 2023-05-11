# frozen_string_literal: true

require 'sinatra/base'
require 'json'
require './helper/request_helper'

# Main app
class RequestDumperApp < Sinatra::Base
  set :bind, '0.0.0.0'
  helpers RequestHelper

  configure :production, :development do
    enable :logging
  end

  get '/*' do
    content_type :json
    echo_request
  end

  post '/*' do
    content_type :json
    echo_request_info
  end

  put '/*' do
    content_type :json
    echo_request
  end

  delete '/*' do
    content_type :json
    echo_request_info
  end

  options '/*' do
    content_type :json
    echo_request
  end
end
