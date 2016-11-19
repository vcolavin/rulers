require 'rulers/version'

module Rulers
  class Application
    `echo debug > debug.txt`
    def call(env)
      [
        200,
        { 'Content-Type' => 'text/html' },
        ['hello from rulers!']
      ]
    end
  end
end
