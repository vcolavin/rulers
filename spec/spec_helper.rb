$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rack/test'
require 'rulers'

class TestApp < Rulers::Application; end

def app
  TestApp.new
end
