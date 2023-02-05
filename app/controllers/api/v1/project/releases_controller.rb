class Api::V1::Project::ReleasesController < Api::V1::Project::BaseController
  before_action :set_release, only: [:show, :destroy]

  def index
    render json: @project.releases
  end

  def show
    render json: @release
  end

  def create
    @release = Release.factory_create(@project)

    render json: @release
  end

  def destroy
    @release.destroy

    head :no_content
  end

  def export
    id = params.require(:id)

    data, filename =
      if id == "HEAD"
        [@project.export.to_json, "#{@project.id}-HEAD-I18n.json"]
      else
        release = get_release(id)
        [@release.export_data, "#{@project.id}-#{@release.id}-I18n.json"]
      end

    send_data @release.export_data, filename: filename, type: Mime[:json]
  end

  protected
  def get_release(id)
    if id == "LAST"
      @project.release.order(created_at: :desc).first
    else
      @project.releases.find(id)
    end
  end

  def set_release
    @release = get_release(params.require(:id))
  end
end
