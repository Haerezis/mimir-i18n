class UserProjectPermission < ApplicationRecord
  belongs_to :user, inverse_of: :permissions
  belongs_to :project, inverse_of: :permissions

  before_save do
    if self.admin
      self.read_write = true
    end
  end

  def as_json2
    Jbuilder.new do |json|
      json.(self,
        :user_id,
        :project_id,
        :read_write,
        :admin,
      )
    end.attributes!
  end
end
