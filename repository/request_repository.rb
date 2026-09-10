# frozen_string_literal: true

# Reads request data from Rack and converts it into the application's request model.
class RequestRepository
  def initialize(request)
    @request = request
  end

  def capture
    { body: request_body }.merge(request_metadata)
  end

  private

  def request_metadata
    {
      params: @request.params.to_json,
      path_info: @request.path_info,
      method: @request.request_method,
      query_string: @request.query_string,
      content_length: @request.content_length,
      media_type: @request.media_type,
      form_data: @request.form_data?,
      headers: @request.env.select { |key, _value| key.start_with?('HTTP_') }
    }
  end

  def request_body
    return @request.POST if @request.form_data?
    return {} if @request.body.nil?

    @request.body.read.then { |raw_body| raw_body.empty? ? {} : JSON.parse(raw_body) }
  end
end
