class Api::V1::ProjectsController < Api::V1::ApplicationController
  before_action :set_project!, except: [:index, :create]

  def index
    render json: current_user.projects.map {|p| p.as_json(user: current_user)}
  end

  def create
    owner = current_user
    name = params.require(:name)
    locales = ([params[:locale], params[:locales]].flatten.reject(&:blank?).map(&:downcase)) & I18nData.languages.keys.map(&:downcase)

    @project = Project.factory_create(
      current_user,
      params.require(:name),
      locales
    )

    render json: @project.as_json(user: current_user)
  end

  def show
    render json: @project.as_json(user: current_user)
  end

  def update
    @project.assign_attributes(project_update_params)
    
    if !@project.save
      bad_request!(@project.errors.join("\n"))
      return
    end

    render json: @project.as_json(user: current_user)
  end

  def destroy
    if !@permission.admin
      forbidden!
      return
    end

    @project.destroy!
  end

  protected

  def project_update_params
    params.permit(:name)
  end

  def set_project!
    @project = current_user.projects.find(params.require(:id))
    @permission = current_user.permissions.find_by(project_id: @project.id)
  end
end
