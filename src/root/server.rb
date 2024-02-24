# frozen_string_literal: true

require 'grape'
require_relative 'routes/grape/tasks_routes'

class Server < Grape::API
  prefix :api
  format :json

  mount TasksRoute
end

Rack::Server.start(app: Server, Port: 3333) if $PROGRAM_NAME == __FILE__
