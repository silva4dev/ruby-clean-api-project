# frozen_string_literal: true

require 'grape'
require_relative 'config/db'
require_relative 'config/env'
require_relative 'config/routes'
require_relative 'config/swagger'

class Server < Grape::API
  mount Routes
  mount SwaggerUI
end

Rack::Server.start(app: Server, Port: Env::PORT) if $PROGRAM_NAME == __FILE__
