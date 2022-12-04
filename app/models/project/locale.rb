class Project::Locale < ApplicationRecord
  belongs_to :project, inverse_of: :locales
  has_many :translations

  def as_json(opts = {})
    code
  end
end
