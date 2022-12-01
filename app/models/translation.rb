class Translation < ApplicationRecord
  belongs_to :project

  def as_json2
    Jbuilder.new do |json|
      json.(self,
        :id,
        :locale,
        :key,
        :value,
      )
    end.attributes!
  end
end
