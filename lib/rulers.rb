require 'rulers/version'
require 'rulers/routing'

module Rulers
  class Application
    `echo debug > debug.txt`

    def call(env)
      klass, action = get_controller_and_action(env)
      controller = klass.new(env)
      text = controller.send(action)

      [
        200,
        { 'Content-Type' => 'text/html' },
        [text]
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
