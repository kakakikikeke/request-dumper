require 'sinatra/base'
require 'json'
require './helper/request-helper'

class RequestDumperApp < Sinatra::Base
  set :bind, '0.0.0.0'
  helpers RequestHelper

  get '/*' do
    content_type :json
    get_request
  end

  post '/*' do
    content_type :json
    get_request
  end

  put '/*' do
    content_type :json
    get_request
  end

  delete '/*' do
    content_type :json
    get_request
  end

  options '/*' do
    content_type :json
    get_request
  end
end
