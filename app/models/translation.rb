class Translation < ApplicationRecord
  belongs_to :translation_key
  belongs_to :project_locale
  delegate :project, :to => :translation_key
end
