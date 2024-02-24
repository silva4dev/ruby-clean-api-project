# frozen_string_literal: true

require 'grape'

class Server < Grape::API
  prefix :api
  format :json

  get :hello do
    { message: 'Hello, world!' }
  end
end

Rack::Server.start(app: Server, Port: 3333) if $PROGRAM_NAME == __FILE__
