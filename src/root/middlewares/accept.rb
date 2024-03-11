# frozen_string_literal: true

class AcceptMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    headers['Accept'] = 'application/json'
    [status, headers, body]
  end
end
