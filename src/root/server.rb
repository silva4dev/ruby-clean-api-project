# frozen_string_literal: true

require 'grape'
require_relative 'config/db'
require_relative 'config/env'
require_relative 'routes/grape/tasks_routes'
require_relative 'middlewares/body_parser'
require_relative 'middlewares/cors'
require_relative 'middlewares/accept'
require_relative 'middlewares/content_type'

class Server < Grape::API
  use ContentTypeMiddleware
  use AcceptMiddleware
  use CorsMiddleware
  use BodyParserMiddleware

  prefix :api

  mount TasksRoute
end

Rack::Server.start(app: Server, Port: Env::PORT) if $PROGRAM_NAME == __FILE__
