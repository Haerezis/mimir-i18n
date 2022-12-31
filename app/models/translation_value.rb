class TranslationValue < ApplicationRecord
  belongs_to :translation_key, class_name: "TranslationKey"

  def as_json(opts = {})
    Jbuilder.new do |json|
      json.(self,
        :id,
        :locale,
        :value,
      )
    end.attributes!
  end
end
