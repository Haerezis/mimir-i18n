class Translation < ApplicationRecord
  belongs_to :project

  def as_json(opts = {})
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
