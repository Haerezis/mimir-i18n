class Api::V1::ProjectsController < Api::V1::BaseController
  before_action :set_project!, except: [:index, :create]

  def index
    projects = []
    projects += current_user.admin_projects.map {|p| p.as_json(user: current_user)}
    projects += current_user.projects.map {|p| p.as_json(user: current_user)}

    render json: projects
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

  def update_locales
    locales = (params[:locales].presence || []).reject(&:blank?).map(&:downcase) & I18nData.languages.keys.map(&:downcase)

    if locales.empty?
      bad_request!("'locales' params empty")
      return
    end

    if !@project.update_locales(locales)
      bad_request!("Something went wrong during update")
      return
    end

    render json: @project.reload.as_json(user: current_user)
  end

  def destroy
    if @project.owner != current_user
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
    @project = Project.find(params.require(:id))
    if @project.owner != current_user
      bad_request!("Current user don't have permission for this project")
      return
    end
  end
end
