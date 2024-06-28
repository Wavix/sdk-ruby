# frozen_string_literal: true

require 'wavix_api'

module WavixApi
  module V1
    class BaseDestroy
      include ::WavixApi::BaseMethods

      class << self
        def call(id = nil)
          instance = new({ id: id })

          instance.validate!

          instance.delete([path, instance.id].join('/'))
        end

        private

        def path
          raise NoMethodError
        end
      end

      def call
        self.class.call(id)
      end
    end
  end
end
