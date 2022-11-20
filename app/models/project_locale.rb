class ProjectLocale < ApplicationRecord
  belongs_to :project, inverse_of: :locales
  has_many :translations

  def as_json2
    code
  end
end
