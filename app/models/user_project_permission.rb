class UserProjectPermission < ApplicationRecord
  belongs_to :user, inverse_of: :permissions
  belongs_to :project, inverse_of: :permissions

  def as_json(opts = {})
    Jbuilder.new do |json|
      json.(self,
        :user_id,
        :project_id,
        :readonly,
      )
    end.attributes!
  end
end
