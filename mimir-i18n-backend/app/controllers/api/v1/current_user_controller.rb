class Api::V1::CurrentUserController < Api::V1::BaseController
  before_action :set_user!

  def show
    render json: @user
  end

  def update
    @user.assign_attributes(params.permit(
      :email,
      :firstname,
      :lastname
    ))

    begin
      @user.save!
      show
    rescue => e
      internal_server_error!(e)
    end
  end

  protected
  def set_user!
    @user = current_user
  end
end
