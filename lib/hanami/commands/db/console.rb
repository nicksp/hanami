require 'hanami/utils/class'
require 'hanami/commands/command'

module Hanami
  module Commands
    class DB
      class Console < Command
        requires 'model.configuration'

        def initialize(options, name)
          super(options)
          @name = name
        end

        def start
          exec connection_string
        end

        private

        attr_reader :name

        def config
          if name
            app_constant = Hanami::Utils::Class.load_from_pattern!(Hanami::Utils::String.new(name).classify)
            Hanami::Utils::Class.load_from_pattern!("#{app_constant}::Application").load!
            Hanami::Utils::Class.load_from_pattern!("#{app_constant}::Model").configuration
          else
            Hanami::Model.configuration
          end
        end

        def adapter_config
          config.adapter_config
        end

        def mapper
          config.mapper
        end

        def adapter_class
          Hanami::Utils::Class.load_from_pattern!(adapter_config.class_name, Hanami::Model::Adapters)
        end

        def connection_string
          adapter_class.new(mapper, adapter_config.uri).connection_string
        end
      end
    end
  end
end
