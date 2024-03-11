# frozen_string_literal: true

require 'json'
require_relative '../../../../data/contracts/db/task_repository'
require_relative '../helpers/postgresql_helper'
require_relative '../../../../core/models/task'

class TaskPostgreSQLRepository
  include TaskRepository

  def find
    query = 'SELECT * FROM tasks'
    data = PostgreSQLHelper.instance.execute(query)
    return [] if data.ntuples.zero?

    data.map do |row|
      Task.new(row['title'], row['description']).tap do |t|
        t.instance_variable_set(:@id, row['id'])
        t.instance_variable_set(:@completed, row['completed'] == 't' ? true : false)
      end
    end
  end

  def add(task)
    query = 'INSERT INTO tasks (title, description, completed) VALUES ($1, $2, $3) RETURNING *'
    data = PostgreSQLHelper.instance.execute(query, [task.title, task.description, task.completed])
    return nil if data.ntuples.zero?

    Task.new(data.first['title'], data.first['description']).tap do |t|
      t.instance_variable_set(:@id, data.first['id'])
      t.instance_variable_set(:@completed, data.first['completed'] == 't' ? true : false)
    end
  end

  def find_by_id(id)
    query = 'SELECT * FROM tasks WHERE id = $1'
    data = PostgreSQLHelper.instance.execute(query, [id])
    return nil if data.ntuples.zero?

    Task.new(data.first['title'], data.first['description']).tap do |t|
      t.instance_variable_set(:@id, data.first['id'])
      t.instance_variable_set(:@completed, data.first['completed'] == 't' ? true : false)
    end
  end

  def update(id, updated_task)
    query = 'UPDATE tasks SET title = $1, description = $2, completed = $3 WHERE id = $4 RETURNING *'
    data = PostgreSQLHelper.instance.execute(query,
                                             [updated_task.title, updated_task.description, updated_task.completed, id])
    return nil if data.ntuples.zero?

    Task.new(data.first['title'], data.first['description']).tap do |t|
      t.instance_variable_set(:@id, data.first['id'])
      t.instance_variable_set(:@completed, data.first['completed'] == 't' ? true : false)
    end
  end

  def destroy(id)
    query = 'DELETE FROM tasks WHERE id = $1 RETURNING *'
    data = PostgreSQLHelper.instance.execute(query, [id])
    return nil if data.ntuples.zero?

    Task.new(data.first['title'], data.first['description']).tap do |t|
      t.instance_variable_set(:@id, data.first['id'])
      t.instance_variable_set(:@completed, data.first['completed'] == 't' ? true : false)
    end
  end
end
