# frozen_string_literal: true

require 'json'

class BodyParserMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)

    if (200..299).cover?(status)
      [status, headers, [JSON.parse(body.first, symbolize_names: true).to_json]]
    else
      [status, headers, [{ error: JSON.parse(body.first, symbolize_names: true) }.to_json]]
    end
  end
end
