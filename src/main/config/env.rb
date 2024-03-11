# frozen_string_literal: true

module Env
  PORT = ENV['PORT']&.to_i || 3333
  POSTGRESQL = {
    DBNAME: ENV['DBNAME'] || 'ruby-grape-clean-api',
    USER: ENV['USER'] || 'postgres',
    PASSWORD: ENV['PASSWORD'] || '123456',
    HOST: ENV['HOST'] || 'localhost',
    PORT: ENV['PORT'] || 5432
  }.freeze
end
