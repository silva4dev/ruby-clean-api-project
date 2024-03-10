# frozen_string_literal: true

require_relative '../../../../../../src/external/db/postgresql/task/task_postgresql_repository'
require_relative '../../../../../../src/external/db/postgresql/helpers/postgresql_helper'
require_relative '../../../../../../src/root/config/env'
require_relative '../../../../../../src/core/models/task'

describe TaskPostgreSQLRepository, type: :integration do
  def make_sut
    task_repository = TaskPostgreSQLRepository.new
    { task_repository: }
  end

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

  it 'Should add a task' do
    sut = make_sut
    output = sut[:task_repository].add(Task.new('Title 1', 'Description 1'))
    expect(output.id).to be_a(String)
    expect(output.title).to eq('Title 1')
    expect(output.description).to eq('Description 1')
  end

  it 'Should return a list of tasks' do
    sut = make_sut
    sut[:task_repository].add(Task.new('Title 1', 'Description 1'))
    sut[:task_repository].add(Task.new('Title 2', 'Description 2'))
    output = sut[:task_repository].find
    expect(output.length).to eq(2)
    expect(output[0].id).to be_a(String)
    expect(output[0].title).to eq('Title 1')
    expect(output[0].description).to eq('Description 1')
    expect(output[1].id).to be_a(String)
    expect(output[1].title).to eq('Title 2')
    expect(output[1].description).to eq('Description 2')
  end

  it 'Should return a task when filtered by id' do
    sut = make_sut
    task = sut[:task_repository].add(Task.new('Title 1', 'Description 1'))
    output = sut[:task_repository].find_by_id(task.id)
    expect(output.id).to be_a(String)
    expect(output.title).to eq('Title 1')
    expect(output.description).to eq('Description 1')
  end

  it 'Should update a task' do
    sut = make_sut
    task = sut[:task_repository].add(Task.new('Title 1', 'Description 1'))
    output = sut[:task_repository].update(task.id, Task.new('Title 1 Updated', 'Description 1 Updated'))
    expect(output.id).to be_a(String)
    expect(output.title).to eq('Title 1 Updated')
    expect(output.description).to eq('Description 1 Updated')
  end

  it 'Should delete a task' do
    sut = make_sut
    task = sut[:task_repository].add(Task.new('Title 1', 'Description 1'))
    sut[:task_repository].destroy(task.id)
    output = sut[:task_repository].find
    expect(output.length).to be(0)
  end
end
