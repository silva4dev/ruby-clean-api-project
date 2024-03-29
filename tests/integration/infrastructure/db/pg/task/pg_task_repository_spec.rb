# frozen_string_literal: true

require_relative '../../../../../../src/infrastructure/db/pg/task/pg_task_repository'
require_relative '../../../../../../src/infrastructure/db/pg/helpers/postgresql_helper'
require_relative '../../../../../../src/domain/models/task'

RSpec.describe PgTaskRepository, type: :integration do
  let(:task_repository) { described_class.new }

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

  it 'adds a task' do
    sut = task_repository.add(Task.new('Title 1', 'Description 1'))
    expect(sut.id).to be_a(Integer)
    expect(sut.title).to eq('Title 1')
    expect(sut.description).to eq('Description 1')
  end

  it 'returns a list of tasks' do
    task_repository.add(Task.new('Title 1', 'Description 1'))
    task_repository.add(Task.new('Title 2', 'Description 2'))
    sut = task_repository.find
    expect(sut.length).to eq(2)
    expect(sut[0].id).to be_a(Integer)
    expect(sut[0].title).to eq('Title 1')
    expect(sut[0].description).to eq('Description 1')
    expect(sut[1].id).to be_a(Integer)
    expect(sut[1].title).to eq('Title 2')
    expect(sut[1].description).to eq('Description 2')
  end

  it 'returns a task when filtered by id' do
    task = task_repository.add(Task.new('Title 1', 'Description 1'))
    sut = task_repository.find_by_id(task.id)
    expect(sut.id).to be_a(Integer)
    expect(sut.title).to eq('Title 1')
    expect(sut.description).to eq('Description 1')
  end

  it 'updates a task' do
    task = task_repository.add(Task.new('Title 1', 'Description 1'))
    sut = task_repository.update(task.id, Task.new('Title 1 Updated', 'Description 1 Updated'))
    expect(sut.id).to be_a(Integer)
    expect(sut.title).to eq('Title 1 Updated')
    expect(sut.description).to eq('Description 1 Updated')
  end

  it 'deletes a task' do
    task = task_repository.add(Task.new('Title 1', 'Description 1'))
    task_repository.destroy(task.id)
    sut = task_repository.find
    expect(sut.length).to be(0)
  end
end
