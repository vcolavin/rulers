require 'multi_json'

module Rulers
  module Model
    class FileModel
      def initialize(filename)
        @filename = filename

        basename = File.split(filename)[-1]
        @id = File.basename(basename, '.json').to_i

        obj = File.read(filename)
        @hash = MultiJson.load(obj)
      end

      def [](name)
        @hash[name.to_s]
      end

      def []=(name, value)
        @hash[name.to_s] = value
      end

      def self.find(id)
        x = FileModel.new("db/quotes/#{id}.json")
        puts '*' * 10
        puts x
        puts '*' * 10
        x
      rescue
        return nil
      end
    end
  end
end