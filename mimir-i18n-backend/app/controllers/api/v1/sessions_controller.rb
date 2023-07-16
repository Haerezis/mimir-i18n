class Api::V1::SessionsController < Devise::SessionsController
  #########################################################################
  protected

  def current_token
    request.env['warden-jwt_auth.token']
  end

  def respond_with(current_user, _opts = {})
    render json: {
      token: current_token
    }
  end

  def respond_to_on_destroy
    if request.headers['Authorization'].present?
      jwt_payload = JWT.decode(
        request.headers['Authorization'].split(' ').last,
        Rails.application.credentials.devise_jwt_secret_key!
      ).first
      current_user = User.find(jwt_payload['sub'])
    end
    
    if current_user
      head :no_content
    else
      render status: :unauthorized,  json: {
        reason: "Couldn't find an active session.",
      }
    end
  end
end
