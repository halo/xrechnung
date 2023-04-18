require 'open-uri'
require 'pathname'
require 'zip'

module Xrechnung
  module Validator
    class Download
      def initialize(path:)
        @path = Pathname.new(path)
      end

      def call
        return if path.exist?

        path.mkpath
        download_validator
        download_scenarios

        puts
        puts "Validator downloaded to #{path}"
      end

      private

      attr_reader :path

      def download_validator
        download(validator_url) do |file|
          next unless file.name.end_with?('-standalone.jar') && !file.name.include?('java8')

          puts "Extracting #{file.name}"
          file.extract path.join(file.name)
        end
      end

      def download_scenarios
        download(scenarios_url) do |file|
          next unless file.name == 'scenarios.xml' || file.name.start_with?('resources/')

          puts "Extracting #{file.name}"
          file.extract path.join(file.name)
        end
      end

      def download(url, &block)
        puts "Downloading #{url}"
        io = URI.open(url) # rubocop:disable Security/Open

        Zip::File.open(io.path) do |zip_file|
          zip_file.each(&block)
        end
      rescue Zip::DestinationFileExistsError => e
        puts e.message
      end

      # Should always point to https://github.com/itplr-kosit/validator/releases/latest
      def validator_url
        'https://github.com/itplr-kosit/validator/releases/download/v1.5.0/validator-1.5.0-distribution.zip'
      end

      def scenarios_url
        # 2.2.x
        'https://github.com/itplr-kosit/validator-configuration-xrechnung/releases/download/release-2022-11-15/validator-configuration-xrechnung_2.2.0_2022-11-15.zip'

        # As of 2023-08-01 use 2.3.x
        # 'https://github.com/itplr-kosit/validator-configuration-xrechnung/releases/download/release-2023-02-17/validator-configuration-xrechnung_2.3.1_2023-02-17.zip'
      end
    end
  end
end
