# frozen_string_literal: true

require_relative '../helpers/http_helper'

class TasksController
  def find(http_request)
    HttpHelper.ok({ message: 'Hello World' })
  end

  def add(http_request); end
  def find_by_id(http_request); end
  def update(http_request); end
  def destroy(http_request); end
end
