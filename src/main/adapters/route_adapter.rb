# frozen_string_literal: true

require 'json'

class RouteAdapter
  def self.adapt(controller)
    lambda do |request|
      http_request = {
        body: (body = request.body.read
               body.empty? ? {} : JSON.parse(body, symbolize_names: true)),
        params: request.params,
        query: request.params,
        headers: request.env
      }
      controller.handle(http_request)
    end
  end
end
