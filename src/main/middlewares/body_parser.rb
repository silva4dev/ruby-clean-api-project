# frozen_string_literal: true

require 'json'

class BodyParserMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    return [status, headers, body] if body.first.nil?

    if (200..299).cover?(status)
      [status, headers, [JSON.parse(body.first, symbolize_names: true).to_json]]
    else
      data = JSON.parse(body.first, symbolize_names: true)
      if data.instance_of?(Array)
        [status, headers, [{ errors: data }.to_json]]
      else
        [status, headers, [{ error: data }.to_json]]
      end
    end
  end
end
