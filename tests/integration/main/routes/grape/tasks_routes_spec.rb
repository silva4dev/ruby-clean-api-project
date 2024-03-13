# frozen_string_literal: true

require_relative '../../../../../src/infrastructure/db/postgresql/helpers/postgresql_helper'
require_relative '../../../../../src/main/config/env'
require_relative '../../../../../src/main/routes/grape/tasks_routes'

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

  it 'Should return a list of tasks' do
    post '/api/tasks', { title: 'Title 1', description: 'Description 1' }.to_json
    expect(last_response.status).to be(204)
    post '/api/tasks', { title: 'Title 2', description: 'Description 2' }.to_json
    expect(last_response.status).to be(204)
    post '/api/tasks', { title: 'Title 3', description: 'Description 3' }.to_json
    expect(last_response.status).to be(204)
    get '/api/tasks'
    sut = JSON.parse(last_response.body, symbolize_names: true)
    expect(sut[:tasks].count).to be(3)
  end

  it 'Should return empty tasks' do
    get '/api/tasks'
    sut = JSON.parse(last_response.body, symbolize_names: true)
    expect(last_response.status).to be(200)
    expect(sut[:tasks].count).to be(0)
  end

  it 'Should return a task when filtered by id' do
    post '/api/tasks', { title: 'Title 1', description: 'Description 1' }.to_json
    expect(last_response.status).to be(204)
    get '/api/tasks'
    expect(last_response.status).to be(200)
    task = JSON.parse(last_response.body, symbolize_names: true)[:tasks].first
    get "/api/tasks/#{task[:id]}"
    expect(last_response.status).to be(200)
    sut = JSON.parse(last_response.body, symbolize_names: true)
    expect(sut[:title]).to eq('Title 1')
    expect(sut[:description]).to eq('Description 1')
  end

  it 'Should return not found if task does not exist' do
    get '/api/tasks/non_existing_id'
    expect(last_response.status).to be(404)
    sut = JSON.parse(last_response.body, symbolize_names: true)
    expect(sut[:error]).to eq('Not Found')
  end

  it 'Should add a task' do
    post '/api/tasks', { title: 'Title 1', description: 'Description 1' }.to_json
    expect(last_response.status).to be(204)
    get '/api/tasks'
    sut = JSON.parse(last_response.body, symbolize_names: true)
    expect(sut[:tasks].first[:title]).to eq('Title 1')
    expect(sut[:tasks].first[:description]).to eq('Description 1')
    expect(sut[:tasks].first[:completed]).to be(false)
  end

  it 'Should update a task' do
    post '/api/tasks', { title: 'Title 1', description: 'Description 1' }.to_json
    expect(last_response.status).to be(204)
    get '/api/tasks'
    expect(last_response.status).to be(200)
    task = JSON.parse(last_response.body, symbolize_names: true)[:tasks].first
    put "/api/tasks/#{task[:id]}", { title: 'Title 2', description: 'Description 2', completed: true }.to_json
    expect(last_response.status).to be(204)
    get '/api/tasks'
    expect(last_response.status).to be(200)
    task = JSON.parse(last_response.body, symbolize_names: true)[:tasks].first
    expect(task[:title]).to eq('Title 2')
    expect(task[:description]).to eq('Description 2')
    expect(task[:completed]).to be(true)
  end

  it 'Should destroy a task' do
    post '/api/tasks', { title: 'Title 1', description: 'Description 1' }.to_json
    expect(last_response.status).to be(204)
    get '/api/tasks'
    expect(last_response.status).to be(200)
    task = JSON.parse(last_response.body, symbolize_names: true)[:tasks].first
    delete "/api/tasks/#{task[:id]}"
    expect(last_response.status).to be(204)
    get '/api/tasks'
    expect(last_response.status).to be(200)
    sut = JSON.parse(last_response.body, symbolize_names: true)
    expect(sut[:tasks].count).to be(0)
  end
end
