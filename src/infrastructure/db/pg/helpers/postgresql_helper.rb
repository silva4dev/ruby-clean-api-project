# frozen_string_literal: true

require 'pg'
require 'singleton'

class PostgreSQLHelper
  include Singleton

  def initialize
    @pg_connection = nil
    @connection_params = nil
  end

  def connect(dbname:, user:, password:, host: 'localhost', port: 5432)
    @connection_params = {
      dbname:,
      user:,
      password:,
      host:,
      port:
    }
    @pg_connection = PG.connect(@connection_params)
  rescue PG::Error => e
    handle_error(e, 'Error connecting to the database.')
    raise e
  end

  def disconnect
    @pg_connection&.close
    @pg_connection = nil
  end

  def execute(query, params = [])
    connect unless connected?
    @pg_connection.exec_params(query, params)
  end

  def connected?
    !(@pg_connection.nil? || @pg_connection.finished?)
  end

  private

  def handle_error(error, message)
    puts "#{message} #{error.message}"
  end
end
