class Api::V1::ProjectsController < Api::V1::ApplicationController
  before_action :set_project!, except: [:index, :create]

  def index
  end

  def create
  end

  def show
  end

  def update
  end

  def destroy
  end

  protected
  def set_project!
    @project = @user.projects.find(params.require(:id))
    @permission = @user.user_project_permissions.find_by(project_id: @project.id)
  end
end
