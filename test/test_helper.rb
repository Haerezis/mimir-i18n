ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  include FactoryBot::Syntax::Methods
  include Devise::Test::IntegrationHelpers
end

require 'mocha/minitest'

if !!ENV["SKIP_VITEJS_COMPILATION"]
  # Prevent vitejs compilation in tests
  module ViteRails::TagHelpers
    def vite_javascript_tag(*args)
      ""
    end
    def vite_stylesheet_tag(*args)
      ""
    end
  end
end

