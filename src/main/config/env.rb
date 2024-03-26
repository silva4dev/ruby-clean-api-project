# frozen_string_literal: true

require 'dotenv'

if ENV['ENVIRONMENT'] == 'test'
  Dotenv.load('.env.test')
elsif ENV['ENVIRONMENT'] == 'development'
  Dotenv.load('.env')
else
  Dotenv.load('.env.production')
end
