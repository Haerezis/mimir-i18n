class Project < ApplicationRecord
  has_many :user_project_permissions
  has_many :users, through: :user_project_permissions

  has_many :locales, class_name: "ProjectLocale", dependent: :destroy
  has_many :translations, dependent: :destroy

  def as_json2(user: nil, with_permissions: false)
    if with_permissions
      permissions = user_project_permissions
    else
      permissions = [user.user_project_permissions.detect {|p| p.project_id == self.id}]
    end

    Jbuilder.new do |json|
      json.(self,
        :id,
        :name
      )

      json.locales(project_locales.map(&:as_json2))

      if permissions
        json.permissions(permissions.map(&:as_json2))
      end
    end.attributes!
  end


  def self.factory_create(owner, name, locales = [])
    project = Project.create(
      name: name,
      #owner: owner
    )

    owner.user_project_permissions.create(
      project: project,
      admin: true,
    )

    locales.each do |locale|
      project.locales.create(code: locale)
    end

    project
  end
end
