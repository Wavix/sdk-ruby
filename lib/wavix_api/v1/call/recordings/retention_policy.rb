# frozen_string_literal: true

module WavixApi
  module V1
    module Call
      module Recordings
        class RetentionPolicy
          include WavixApi::BaseMethods

          class << self
            def call(params = {})
              instance = new(params)

              instance.validate!

              instance.get('v1/recordings/retention-policy')
            end
          end
        end
      end
    end
  end
end
