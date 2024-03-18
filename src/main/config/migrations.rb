# frozen_string_literal: true

require 'sequel'
require_relative '../config/env'

DB = Sequel.connect(
  adapter: ENV['DRIVER'] || 'postgres',
  host: ENV['POSTGRES_HOST'] || 'localhost',
  database: ENV['POSTGRES_DB'] || 'ruby-grape-clean-api',
  user: ENV['POSTGRES_USER'] || 'postgres',
  password: ENV['POSTGRES_PASSWORD'] || '123456',
  port: ENV['POSTGRES_PORT'] || 5432
)

Sequel.extension :migration
Sequel::Migrator.run(DB, './src/infrastructure/db/migrations')
