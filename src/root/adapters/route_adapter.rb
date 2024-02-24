# frozen_string_literal: true

require 'json'

class RouteAdapter
  def self.adapt(controller, method_name)
    lambda do |request|
      http_request = {
        body: (body = request.body.read
               body.empty? ? {} : JSON.parse(body, symbolize_names: true)),
        params: request.params,
        query: request.params,
        headers: request.env
      }
      controller.send(method_name.to_sym, http_request)
    end
  end
end
