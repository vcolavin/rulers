require 'erubis'

module Rulers
  class Controller
    attr_reader :env

    def initialize(env)
      @env = env
    end

    def render(view_name)
      filename = File.join(
        'app',
        'views',
        controller_name,
        "#{view_name}.html.erb"
      )
      template = File.read(filename)

      eruby = Erubis::Eruby.new(template)
      eruby.result(view_vars)
    end

    def controller_name
      klass = self.class.to_s.gsub(/Controller$/, '')
      Rulers.to_underscore(klass)
    end

    def view_vars
      self.instance_variables.inject({}) do |memo, var|
        memo.merge(var => self.instance_variable_get(var))
      end
    end
  end
end