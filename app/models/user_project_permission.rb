class UserProjectPermission < ApplicationRecord
  belongs_to :user, inverse_of: :user_project_permissions
  belongs_to :project, inverse_of: :user_project_permissions
end
