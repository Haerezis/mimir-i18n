class Project < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :permissions, class_name: "UserProjectPermission", dependent: :destroy
  has_many :users, through: :permissions

  has_many :locales, class_name: "Project::Locale", dependent: :destroy
  has_many :translations, class_name: "TranslationKey", dependent: :destroy

  def as_json(opts = {})
    user = opts[:user]
    with_permissions = opts.dig(:with_permissions, false)

    if with_permissions
      permissions = self.permissions
    else
      permissions = [user&.permissions&.detect {|p| p.project_id == self.id}].compact
    end

    Jbuilder.new do |json|
      json.(self,
        :id,
        :name,
      )

      json.owner(owner.as_json(opts))

      json.locales(locales.map(&:as_json))

      if permissions
        json.permissions(permissions.map(&:as_json))
      end
    end.attributes!
  end


  def self.factory_create(owner, name, locales = [])
    project = Project.create(
      name: name,
      owner: owner
    )

    locales.each do |locale|
      project.locales.create(code: locale)
    end

    project
  end
end
