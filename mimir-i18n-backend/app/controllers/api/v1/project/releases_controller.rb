class Api::V1::Project::ReleasesController < Api::V1::Project::BaseController
  before_action :set_release, only: [:show, :destroy]

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
      @project.release.order(created_at: :desc).first
    else
      @project.releases.find(id)
    end
  end

  def set_release
    @release = get_release(params.require(:id))
  end
end
