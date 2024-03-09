# frozen_string_literal: true

class ServerError < StandardError
  def initialize
    super('Internal server error')
    @name = 'ServerError'
  end
end
