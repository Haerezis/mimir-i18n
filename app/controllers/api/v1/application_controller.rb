class Api::V1::ApplicationController < ActionController::Api
  before_action :authenticate_user!
end
