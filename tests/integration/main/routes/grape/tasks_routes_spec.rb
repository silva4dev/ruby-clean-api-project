# frozen_string_literal: true

require_relative '../../../../../src/infrastructure/db/pg/helpers/postgresql_helper'
require_relative '../../../../../src/main/routes/grape/tasks_routes'

RSpec.describe TasksRoute, type: :integration do
  before(:all) do
    PostgreSQLHelper.instance.connect(
      dbname: ENV.fetch('POSTGRES_DB', nil),
      user: ENV.fetch('POSTGRES_USER', nil),
      password: ENV.fetch('POSTGRES_PASSWORD', nil),
      host: ENV.fetch('POSTGRES_HOST', nil),
      port: ENV.fetch('POSTGRES_PORT', nil)
    )
  end

  after(:all) do
    PostgreSQLHelper.instance.disconnect
  end

  before(:each) do
    PostgreSQLHelper.instance.execute('DELETE FROM tasks')
  end

  it 'returns a list of tasks' do
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

  it 'returns empty tasks' do
    get '/api/tasks'
    sut = JSON.parse(last_response.body, symbolize_names: true)
    expect(last_response.status).to be(200)
    expect(sut[:tasks].count).to be(0)
  end

  it 'returns a task when filtered by id' do
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

  it 'does not return a task when passing invalid id' do
    get '/api/tasks/invalid_id'
    expect(last_response.status).to be(404)
    sut = JSON.parse(last_response.body, symbolize_names: true)
    expect(sut[:error]).to eq('Not Found')
  end

  it 'adds a task' do
    post '/api/tasks', { title: 'Title 1', description: 'Description 1' }.to_json
    expect(last_response.status).to be(204)
    get '/api/tasks'
    sut = JSON.parse(last_response.body, symbolize_names: true)
    expect(sut[:tasks].first[:title]).to eq('Title 1')
    expect(sut[:tasks].first[:description]).to eq('Description 1')
    expect(sut[:tasks].first[:completed]).to be(false)
  end

  it 'updates a task' do
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

  it 'does not update a task when passing invalid id' do
    put '/api/tasks/invalid_id', { title: 'Title 2', description: 'Description 2', completed: true }.to_json
    expect(last_response.status).to be(404)
    sut = JSON.parse(last_response.body, symbolize_names: true)
    expect(sut[:error]).to eq('Not Found')
  end

  it 'destroys a task' do
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

  it 'does not destroy a task when passing invalid id' do
    delete '/api/tasks/invalid_id'
    expect(last_response.status).to be(404)
    sut = JSON.parse(last_response.body, symbolize_names: true)
    expect(sut[:error]).to eq('Not Found')
  end
end
