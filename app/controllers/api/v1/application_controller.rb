class Api::V1::ApplicationController < ActionController::Api
  before_action :authenticate_user!

  rescue_from Exception, with: :internal_server_error!
  rescue_from ActionController::ParameterMissing, with: :parameter_missing!

  protected
  def not_found!(msg)
    render status: :not_found,  json: {
      reason: msg
    }
  end

  def bad_request!(msg, error_code: 0, resource: nil)
    render status: :bad_request,  json: {
      reason: msg,
      code: error_code,
    }
  end

  def forbidden!
    render status: :forbidden, json: {
      reason: "API endpoint forbidden for current user"
    }
  end

  def internal_server_error!(e)
    render status: 500, json: {
      reason: current_user&.ceris ? "Internal server error : #{e}" : "Internal server error" 
    }
  end

  def parameter_missing!(e)
    bad_request!("Missing parameter : #{e.param}")
  end
end
