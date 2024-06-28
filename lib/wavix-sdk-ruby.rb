# frozen_string_literal: true

require 'wavix_api'

Dir[File.join(__dir__, 'wavix_api/**/*.rb')].sort.each { |file| require file }
