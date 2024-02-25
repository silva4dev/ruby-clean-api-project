# frozen_string_literal: true

require 'json'
require_relative '../../../../data/contracts/db/task_repository'
require_relative '../helpers/postgresql_helper'

class TasksPostgreSQLRepository
  include TaskRepository

  def find
    query = 'SELECT * FROM tasks'
    data = PostgreSQLHelper.instance.execute(query)
    data.map { |row| row.transform_keys(&:to_sym) }
  end

  def add(task)
    query = 'INSERT INTO tasks (title, description, completed) VALUES ($1, $2, $3)
             RETURNING id, title, description, completed'
    data = PostgreSQLHelper.instance.execute(query, [task.title, task.description, task.completed])
    JSON.parse(data.first.to_json, symbolize_names: true)
  end

  def find_by_id(id)
    query = 'SELECT * FROM tasks WHERE id = $1'
    data = PostgreSQLHelper.instance.execute(query, [id])
    JSON.parse(data.first.to_json, symbolize_names: true)
  end

  def update(id, updated_task)
    query = 'UPDATE tasks SET title = $1, description = $2, completed = $3 WHERE id = $4
    RETURNING id, title, description, completed'
    data = PostgreSQLHelper.instance.execute(query,
                                             [updated_task.title, updated_task.description, updated_task.completed, id])
    JSON.parse(data.first.to_json, symbolize_names: true)
  end

  def destroy(id)
    query = 'DELETE FROM tasks WHERE id = $1 RETURNING id, title, description, completed'
    data = PostgreSQLHelper.instance.execute(query, [id])
    JSON.parse(data.first.to_json, symbolize_names: true)
  end
end
