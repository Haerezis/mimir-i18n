class TranslationKey < ApplicationRecord
  belongs_to :project
  has_many :values, class_name: "TranslationValue", dependent: :destroy

  def as_json(opts = {})
    Jbuilder.new do |json|
      json.(self,
        :id,
        :key,
        :values,
      )
    end.attributes!
  end
end
