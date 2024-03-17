# frozen_string_literal: true

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
  # version 'v1'
  format :json

  mount TasksRoute
  add_swagger_documentation(
    info: {
      title: 'Grape Clean API',
      description: 'Gerenciador de tarefas'
    },
    mount_path: '/swagger_doc'
  )
end
