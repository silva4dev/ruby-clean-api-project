# frozen_string_literal: true

module Env
  PORT = ENV['PORT']&.to_i || 5050
  POSTGRESQL = {
    DBNAME: ENV['POSTGRES_DB'] || 'ruby-grape-clean-api',
    USER: ENV['POSTGRES_USER'] || 'postgres',
    PASSWORD: ENV['POSTGRES_PASSWORD'] || '123456',
    HOST: ENV['POSTGRES_HOST'] || 'localhost',
    PORT: ENV['POSTGRES_PORT'] || 5432
  }.freeze
end
