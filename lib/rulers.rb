require 'rulers/version'
require 'rulers/routing'

module Rulers
  class Application
    `echo debug > debug.txt`
    def call(env)
      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      text = controller.send(act)
      [
        200,
        { 'Content-Type' => 'text/html' },
        ['hello from rulers!']
      ]
    end
  end

  class Controller
    attr_reader :env

    def initialize(env)
      @env = env
    end
  end
end
