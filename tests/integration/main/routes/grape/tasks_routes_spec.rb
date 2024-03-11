# frozen_string_literal: true

require_relative '../../../../../src/external/db/postgresql/helpers/postgresql_helper'
require_relative '../../../../../src/root/config/env'
require_relative '../../../../../src/root/routes/grape/tasks_routes'

describe TasksRoute, type: :integration do
  before(:all) do
    PostgreSQLHelper.instance.connect(
      dbname: Env::POSTGRESQL[:DBNAME],
      user: Env::POSTGRESQL[:USER],
      password: Env::POSTGRESQL[:PASSWORD],
      host: Env::POSTGRESQL[:HOST],
      port: Env::POSTGRESQL[:PORT]
    )
  end

  after(:all) do
    PostgreSQLHelper.instance.disconnect
  end

  before(:each) do
    PostgreSQLHelper.instance.execute('DELETE FROM tasks')
  end

  it 'Should return empty tasks' do
    get '/api/tasks'
    sut = JSON.parse(last_response.body, symbolize_names: true)
    expect(sut[:tasks].count).to be(0)
  end
end
