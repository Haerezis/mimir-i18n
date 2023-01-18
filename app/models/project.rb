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

  def update_locales(locales)
    ApplicationRecord.transaction do
      initial_locales = self.locales.map(&:code)

      added_locales = locales - initial_locales
      removed_locales = initial_locales - locales

      translation_keys = self.translations.to_a

      self.locales.where(code: removed_locales).destroy_all
      TranslationValue.where(translation_key_id: translation_keys.map(&:id), locale: removed_locales).destroy_all


      added_locales.each do |added_locale|
        self.locales.new(code: added_locale).save!

        translation_keys.each do |key|
          key.values.new(
            locale: added_locale,
            value: ""
          ).save!
        end
      end
    end

    return true
  end
end
