# frozen_string_literal: true

module WavixApi
  module V1
    module Profile
      class AccountConfig
        include WavixApi::BaseMethods

        class << self
          def call(params = {})
            instance = new(params)

            instance.validate!

            instance.get('v1/profile/config')
          end
        end
      end
    end
  end
end
