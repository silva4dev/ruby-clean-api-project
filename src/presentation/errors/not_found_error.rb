# frozen_string_literal: true

class NotFoundError < StandardError
  def initialize
    super('Not Found')
    @name = 'NotFoundError'
  end
end
