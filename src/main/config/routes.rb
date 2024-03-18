# frozen_string_literal: true

require 'json'
require 'grape'
require 'grape-swagger'
require_relative '../middlewares/accept'
require_relative '../middlewares/cors'
require_relative '../middlewares/body_parser'
require_relative '../middlewares/content_type'
require_relative '../routes/grape/tasks_routes'

class Routes < Grape::API
  use CorsMiddleware
  use AcceptMiddleware
  use ContentTypeMiddleware
  use BodyParserMiddleware

  prefix 'api'
  format :json

  mount TasksRoute

  get '/swagger_doc' do
    content_type :json
    json_content = File.read('./src/main/swagger/swagger.json')
    JSON.parse(json_content)
  end
end
