# frozen_string_literal: true

require_relative '../helpers/http_helper'

class TasksController
  def find(http_request)
    HttpHelper.ok({ message: 'Hello World' })
  end
end
