# frozen_string_literal: true

module WavixApi
  module V1
    module Buy
      module Carts
        class Find
          include WavixApi::BaseMethods

          class << self
            def call(params = {})
              instance = new(params)

              instance.validate!

              instance.get('v1/buy/cart')
            end
          end
        end
      end
    end
  end
end
