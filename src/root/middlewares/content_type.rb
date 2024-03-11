# frozen_string_literal: true

class ContentTypeMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    request = ::Rack::Request.new(env)
    status, headers, body = @app.call(env)
    if request.content_type != 'application/json'
      response = ::Rack::Response.new({
        error: 'Unsupported Media Type. Use Content-Type: application/json'
      }.to_json, 415, { 'Content-Type' => 'application/json' })
      return response.finish
    end
    headers['Content-Type'] = 'application/json'
    [status, headers, body]
  end
end
