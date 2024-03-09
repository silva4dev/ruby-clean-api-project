# frozen_string_literal: true

require_relative '../contracts/http'
require_relative '../errors/server_error'

class HttpHelper
  include HttpResponse

  def self.ok(data)
    { status_code: 200, body: data }
  end

  def self.server_error
    { status_code: 500, body: ServerError.new }
  end
end
