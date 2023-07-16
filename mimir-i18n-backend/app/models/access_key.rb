class AccessKey < ApplicationRecord
  belongs_to :project

  def as_json(opts = {})
    Jbuilder.new do |json|
      json.(self,
        :id,
        :project_id,
        :name,
        :value,
        :created_at,
        :updated_at,
      )
    end.attributes!
  end

  def self.factory_create(project, name, key_value = nil)
    if key_value.blank?
      key_value = SecureRandom.alphanumeric(50)
    end

    access_key = AccessKey.new(
      name: name,
      project: project,
      value: key_value
    )

    access_key.save!

    access_key
  end
end
