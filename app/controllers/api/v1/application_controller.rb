class Api::V1::ApplicationController < ActionController::API
  before_action :authenticate_user!
  #before_action :bypass_signin!

  rescue_from Exception do |exception|
    if Rails.env.test?
      raise exception
    end
    internal_server_error!(exception)
  end
  rescue_from ActionController::ParameterMissing, with: :parameter_missing!
  rescue_from ActiveRecord::RecordNotFound, with: :not_found!

  protected
  def authenticate_user!
    catch(:warden) do
      super
      return
    end
    head :unauthorized
  end 

  def bypass_signin!
    bypass_sign_in User.first, scope: :user
  end


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
    puts e
    render status: 500, json: {
      reason: "Internal server error" 
    }
  end

  def parameter_missing!(e)
    bad_request!("Missing parameter : #{e.param}")
  end
end
