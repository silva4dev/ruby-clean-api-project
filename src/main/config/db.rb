# frozen_string_literal: true

require_relative '../config/env'
require_relative '../../infrastructure/db/postgresql/helpers/postgresql_helper'

PostgreSQLHelper.instance.connect(
  dbname: Env::POSTGRESQL[:DBNAME],
  user: Env::POSTGRESQL[:USER],
  password: Env::POSTGRESQL[:PASSWORD],
  host: Env::POSTGRESQL[:HOST],
  port: Env::POSTGRESQL[:PORT]
)
