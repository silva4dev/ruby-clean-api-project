# frozen_string_literal: true

require 'json'
require_relative '../../../../application/contracts/db/task_repository'
require_relative '../helpers/postgresql_helper'
require_relative '../../../../domain/models/task'

class PgTaskRepository
  include TaskRepository

  def find
    query = 'SELECT * FROM tasks'
    data = PostgreSQLHelper.instance.execute(query)
    return [] if data.ntuples.zero?

    data.map do |row|
      Task.new(row['title'], row['description']).tap do |t|
        t.instance_variable_set(:@id, row['id'].to_i)
        t.instance_variable_set(:@completed, row['completed'] == 't' ? true : false)
      end
    end
  end

  def add(task)
    query = 'INSERT INTO tasks (title, description, completed) VALUES ($1, $2, $3) RETURNING *'
    data = PostgreSQLHelper.instance.execute(query, [task.title, task.description, task.completed])
    return nil if data.ntuples.zero?

    Task.new(data.first['title'], data.first['description']).tap do |t|
      t.instance_variable_set(:@id, data.first['id'].to_i)
      t.instance_variable_set(:@completed, data.first['completed'] == 't' ? true : false)
    end
  end

  def find_by_id(id)
    return nil unless id.to_i.to_s == id.to_s

    query = 'SELECT * FROM tasks WHERE id = $1'
    data = PostgreSQLHelper.instance.execute(query, [id.to_i])
    return nil if data.ntuples.zero?

    Task.new(data.first['title'], data.first['description']).tap do |t|
      t.instance_variable_set(:@id, data.first['id'].to_i)
      t.instance_variable_set(:@completed, data.first['completed'] == 't' ? true : false)
    end
  end

  def update(id, updated_task)
    query = 'UPDATE tasks SET title = $1, description = $2, completed = $3 WHERE id = $4 RETURNING *'
    data = PostgreSQLHelper.instance.execute(query,
                                             [updated_task.title, updated_task.description, updated_task.completed,
                                              id.to_i])
    return nil if data.ntuples.zero?

    Task.new(data.first['title'], data.first['description']).tap do |t|
      t.instance_variable_set(:@id, data.first['id'].to_i)
      t.instance_variable_set(:@completed, data.first['completed'] == 't' ? true : false)
    end
  end

  def destroy(id)
    query = 'DELETE FROM tasks WHERE id = $1 RETURNING *'
    data = PostgreSQLHelper.instance.execute(query, [id.to_i])
    return nil if data.ntuples.zero?

    Task.new(data.first['title'], data.first['description']).tap do |t|
      t.instance_variable_set(:@id, data.first['id'].to_i)
      t.instance_variable_set(:@completed, data.first['completed'] == 't' ? true : false)
    end
  end
end
