class ProjectLocale < ApplicationRecord
  belongs_to :project, inverse_of: :locales
  has_many :translations
end
