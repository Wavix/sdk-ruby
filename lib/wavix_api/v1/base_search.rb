# frozen_string_literal: true

require 'wavix_api'

module WavixApi
  module V1
    class BaseSearch
      include WavixApi::BaseMethods

      class << self
        def call(params = {})
          instance = new(params)

          instance.validate!

          instance.get(path)
        end

        private

        def path
          raise NoMethodError
        end
      end

      def call
        self.class.call(@params)
      end
    end
  end
end
