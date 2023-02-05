class Release < ApplicationRecord
  belongs_to :project

  before_save do
    self.hash = Digest::SHA256.hexdigest(self.export_data)
  end

  def as_json(opts = {})
    Jbuilder.new do |json|
      json.(self,
        :id,
        :project_id,
        :created_at,
      )
    end.attributes!
  end

  def self.factory_create(project)
    export_data = project.export

    release = Release.new(
      project: project,
      export_data: export_data.to_json
    )

    release.save!

    release
  end
end
