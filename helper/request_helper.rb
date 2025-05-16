# frozen_string_literal: true

# A module that manages meta information about requests
module RequestHelper
  def echo_request
    request_info = fields
    logger.info request_info
    request_info.to_json
  end

  private

  def fields # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    body = {} unless request.body.nil?
    {
      body: body,
      params: params.to_json,
      path_info: request.path_info,
      method: request.request_method,
      query_string: request.query_string,
      content_length: request.content_length,
      media_type: request.media_type,
      form_data: request.form_data?,
      headers: request.env.select { |k, _| k.start_with?('HTTP_') }
    }
  end

  def hidden_fields
    {
      # sheme: request.scheme,
      # script_name: request.script_name,
      # port: request.port,
      # host: request.host,
      # get: request.get?,
      # referer: request.referer,
      # user_agent: request.user_agent,
      # cookies: request.cookies,
      # xhr: request.xhr?,
      # url: request.url,
      # path: request.path,
      # ip: request.ip,
      # secure: request.secure?,
      # env: request.env
    }
  end
end
