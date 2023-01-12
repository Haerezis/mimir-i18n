class TranslationKey < ApplicationRecord
  belongs_to :project
  has_many :values, class_name: "TranslationValue", dependent: :destroy

  def as_json(opts = {})
    Jbuilder.new do |json|
      json.(self,
        :id,
        :project_id,
        :key,
      )
      json.values( values.map(&:as_json) )
    end.attributes!
  end
end
