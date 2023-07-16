ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require 'mocha/minitest'

module MimirI18nBackend
  module Test
    module Devise
      def auto_sign_in(user)
        @__auto_signin_user = user
      end

      %w(get post patch put head delete cookies assigns follow_redirect!).each do |method|
        define_method(method) do |path, **args|
          if @__auto_signin_user
            sign_in(@__auto_signin_user, scope: :user)
          end
          super(path, **args)
        end
      end
    end
  end
end


class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  include FactoryBot::Syntax::Methods
  include Devise::Test::IntegrationHelpers
end

ActionDispatch::IntegrationTest.class_eval do
  include MimirI18nBackend::Test::Devise
end
