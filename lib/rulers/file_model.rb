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
        FileModel.new("db/quotes/#{id}.json")
      rescue
        return nil
      end

      def self.all
        files = Dir['db/quotes/*.json']
        files.map { |file| FileModel.new(file) }
      end

      def self.create(attrs)
        object_hash = {}
        object_hash['submitter'] = attrs['submitter'] || ''
        object_hash['quote'] = attrs['quote'] || ''
        object_hash['attribution'] = attrs['attribution'] || ''

        files = Dir['db/quotes/*.json']
        names = files.map { |file| file.split('/')[-1] }
        id = names.map(&:to_i).max + 1

        File.open("db/quotes/#{id}.json", 'w') do |file|
          file.write( <<-TEMPLATE
{
  "submitter": "#{object_hash['submitter']}",
  "quote": "#{object_hash['quote']}",
  "attribution": "#{object_hash['attribution']}"
}
            TEMPLATE
          )
        end
        FileModel.new("db/quotes/#{id}.json")
      end
    end
  end
end