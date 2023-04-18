require 'tty-command'
require 'pathname'

module Xrechnung
  module Validator
    class Run
      def initialize(path:, files:)
        @path = Pathname.new(path)
        @files = files
      end

      def call
        TTY::Command.new(uuid: false).run('java', *arguments)
      end

      private

      attr_reader :path, :files

      def arguments
        [
          '-jar', jar_path,
          '--repository', path,
          '--scenarios', scenario_path,
          '--html',
          '--output-directory', result_path,
          files
        ]
      end

      def jar_path
        path.children.detect { |entry| entry.basename.to_s.end_with?('-standalone.jar') }
      end

      def scenario_path
        path.join('scenarios.xml')
      end

      def result_path
        path.join('results')
      end
    end
  end
end
