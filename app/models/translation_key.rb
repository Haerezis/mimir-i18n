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
      json.values( values.map {|v| [v.locale, v]}.to_h )
    end.attributes!
  end
end
