class Api::V1::Project::AccessKeysController < Api::V1::Project::BaseController
  before_action :set_access_key, only: [:show, :destroy]

  def index
    render json: @project.access_keys
  end

  def show
    render json: @access_key
  end

  def create
    name = params.require(:name)
    key = params[:key].presence

    @access_key = AccessKey.factory_create(@project, name, key)

    render json: @access_key
  end

  def destroy
    @access_key.destroy

    head :no_content
  end

  protected
  def set_access_key
    @access_key = @project.access_keys.find(params.require(:id))
  end
end
