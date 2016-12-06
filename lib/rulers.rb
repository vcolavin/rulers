require 'rulers/version'
require 'rulers/routing'
require 'rulers/util'
require 'rulers/dependencies'
require 'rulers/controller'

module Rulers
  class Application
    `echo debug > debug.txt`

    def call(env)
      return a_404 if favicon?(env['PATH_INFO'])

      klass, action = get_controller_and_action(env)
      controller = klass.new(env)
      text = controller.send(action)

      [
        200,
        { 'Content-Type' => 'text/html' },
        [text]
      ]
    end

    def a_404
      [
        404,
        {'Content-Type' => 'text/html'},
        []
      ]
    end

    def favicon?(path)
      path == '/favicon.ico'
    end
  end
end
