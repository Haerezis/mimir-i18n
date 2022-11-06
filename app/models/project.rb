class Project < ApplicationRecord
  has_many :user_project_permissions
  has_many :users, through: :user_project_permissions

  has_many :project_locales, dependent: :destroy
  has_many :translation_keys, dependent: :destroy
  has_many :translations, through: :translation_keys, dependent: :destroy
end
