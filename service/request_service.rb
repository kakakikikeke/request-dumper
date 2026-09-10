# frozen_string_literal: true

# Executes the request-dumping use case.
class RequestService
  def initialize(repository, logger)
    @repository = repository
    @logger = logger
  end

  def capture_request
    request_info = @repository.capture
    @logger.info request_info
    request_info
  end
end
