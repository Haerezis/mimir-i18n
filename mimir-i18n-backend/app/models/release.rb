class Release < ApplicationRecord
  belongs_to :project

  before_save do
    self.sha = Digest::SHA256.hexdigest(self.export_data)
  end

  def as_json(opts = {})
    Jbuilder.new do |json|
      json.(self,
        :id,
        :project_id,
        :created_at,
        :sha,
        :message,
      )
      json.sha_short(sha[-8..])

      json.export_url(Rails.application.routes.url_helpers.export_api_v1_project_release_url(self.project_id, self))
    end.attributes!
  end

  def self.factory_create(project, message)
    release = Release.new(
      project: project,
      message: message,
      export_data: project.export.to_json
    )

    release.save!

    release
  end

  def self.current(project)
    Jbuilder.new do |json|
      json.id(0)
      json.project_id(project.id)
      json.created_at(Time.now)
      json.sha("CURRENT")
      json.sha_short("CURRENT")
      json.message("")
      json.export_url(Rails.application.routes.url_helpers.export_api_v1_project_release_url(project, "CURRENT"))
    end.attributes!
  end
end
