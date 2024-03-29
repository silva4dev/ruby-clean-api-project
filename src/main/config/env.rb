# frozen_string_literal: true

require 'dotenv'

if ENV['ENVIRONMENT'] == 'test'
  Dotenv.load('.env.test')
else
  Dotenv.load('.env')
end
