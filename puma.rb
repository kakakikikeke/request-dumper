# frozen_string_literal: true

lowlevel_error_handler do |_error, _env, status|
  body = { error: 'Bad Request' }.to_json
  [status, { 'content-type' => 'application/json', 'content-length' => body.bytesize.to_s }, [body]]
end
