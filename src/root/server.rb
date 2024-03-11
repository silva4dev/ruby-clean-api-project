# frozen_string_literal: true

require 'grape'
require_relative 'config/db'
require_relative 'config/env'
require_relative 'routes/grape/tasks_routes'
require_relative 'middlewares/http_response_middleware'

class Server < Grape::API
  use HttpResponseMiddleware

  prefix :api
  format :json

  mount TasksRoute
end

Rack::Server.start(app: Server, Port: Env::PORT) if $PROGRAM_NAME == __FILE__
