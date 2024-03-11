# frozen_string_literal: true

class HttpResponseMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    if (200..299).cover?(status)
      [status, headers, [body.join("\n")]]
    else
      [status, headers, [{ error: body.first.to_s.gsub(/^"|"$/, '') }.to_json]]
    end
  end
end
