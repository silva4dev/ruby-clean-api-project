# frozen_string_literal: true

require_relative '../contracts/http'

class HttpHelper
  include HttpResponse

  def self.ok(data)
    { status_code: 200, body: data }
  end
end
