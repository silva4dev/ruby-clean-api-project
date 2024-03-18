# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    drop_table?(:tasks)

    create_table(:tasks) do
      primary_key :id
      String :title
      String :description
      Boolean :completed, default: false
      DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP
      DateTime :updated_at, default: Sequel::CURRENT_TIMESTAMP
    end
  end
end
