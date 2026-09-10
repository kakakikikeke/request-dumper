# frozen_string_literal: true

# Translates the request-dumping use case into an HTTP response body.
class RequestController
  def initialize(service)
    @service = service
  end

  def echo
    @service.capture_request.to_json
  end
end
