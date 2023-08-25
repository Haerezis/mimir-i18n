class Api::V1::Project::ReleasesController < Api::V1::Project::BaseController
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :set_release!, only: [:show, :destroy]

  skip_before_action :set_project!, only: [:export]
  skip_before_action :authenticate_user!, only: [:export]

  def index
    render json: [Release.current(@project), *@project.releases]
  end

  def show
    render json: @release
  end

  def create
    message = params.require(:message)

    @release = Release.factory_create(
      @project,
      message
    )

    render json: @release
  end

  def destroy
    @release.destroy

    head :no_content
  end

  def export
    @project = Project.find(params.require(:project_id))
    authenticate_with_http_token do |token, options|
      @access_key = @project.access_keys.where(value: token).first
    end
    if @access_key.nil? && current_user.nil?
      head :unauthorized
      return
    end



    id = params.require(:id)

    data, filename =
      if id == "CURRENT"
        [@project.export.to_json, "#{@project.id}-CURRENT-I18n.json"]
      else
        @release = get_release(id)
        [@release.export_data, "#{@project.id}-#{@release.id}-#{@release.hash}-I18n.json"]
      end

    send_data data, filename: filename, type: Mime[:json]
  end

  protected
  def get_release(id)
    if id == "HEAD"
      @project.releases.order(created_at: :desc).first
    else
      @project.releases.find(id)
    end
  end

  def set_release!
    @release = get_release(params.require(:id))
  end
end
