# frozen_string_literal: true

require 'sequel'
require_relative '../config/env'

DB = Sequel.connect(
  adapter: ENV.fetch('DRIVER', nil),
  host: ENV.fetch('POSTGRES_HOST', nil),
  database: ENV.fetch('POSTGRES_DB', nil),
  user: ENV.fetch('POSTGRES_USER', nil),
  password: ENV.fetch('POSTGRES_PASSWORD', nil),
  port: ENV.fetch('POSTGRES_PORT', nil)
)

Sequel.extension :migration
Sequel::Migrator.run(DB, './src/infrastructure/db/migrations')
