class Api::V1::Project::BaseController < Api::V1::BaseController
  before_action :set_project!
  protected

  def set_project!
    @project = Project.find(params.require(:project_id))
    if @project.owner != current_user
      bad_request!("Current user don't have permission for this project")
      return
    end
  end
end

