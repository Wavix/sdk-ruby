# frozen_string_literal: true

module WavixApi
  module V1
    module Buy
      module Carts
        class Checkout
          include WavixApi::BaseMethods

          class << self
            def call(params = {})
              instance = new(params)

              instance.validate!

              instance.post('v1/buy/cart/checkout')
            end
          end
        end
      end
    end
  end
end
