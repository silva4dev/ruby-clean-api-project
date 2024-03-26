# frozen_string_literal: true

require_relative '../config/env'
require_relative '../../infrastructure/db/pg/helpers/postgresql_helper'

PostgreSQLHelper.instance.connect(
  dbname: ENV.fetch('POSTGRES_DB', nil),
  user: ENV.fetch('POSTGRES_USER', nil),
  password: ENV.fetch('POSTGRES_PASSWORD', nil),
  host: ENV.fetch('POSTGRES_HOST', nil),
  port: ENV.fetch('POSTGRES_PORT', nil)
)
