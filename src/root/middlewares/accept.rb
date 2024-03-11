# frozen_string_literal: true

class AcceptMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    request = ::Rack::Request.new(env)
    status, headers, body = @app.call(env)
    if request.env['HTTP_ACCEPT'] != 'application/json'
      response = ::Rack::Response.new({
        error: 'Not Acceptable. Use Accept: application/json'
      }.to_json, 406, { 'Content-Type' => 'application/json' })
      return response.finish
    end
    [status, headers, body]
  end
end
