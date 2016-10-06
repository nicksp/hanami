module Hanami
  module Components
    # Catch all for defined components
    #
    # @since x.x.x
    class All < Component
      register_as 'all'
      requires 'model'

      def resolve
        Hanami.boot
        true
      end
    end
  end
end
