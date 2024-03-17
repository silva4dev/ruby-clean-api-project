# frozen_string_literal: true

require 'grape'
require 'erb'

class SwaggerUI < Grape::API
  content_type :html, 'text/html'

  get '/api-docs' do
    path = File.expand_path('index.html.erb', './src/main/swagger')
    ERB.new(File.read(path)).result(binding)
  end
end
