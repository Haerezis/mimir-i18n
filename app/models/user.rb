class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  has_many :user_project_permissions
  has_many :projects, through: :user_project_permissions

  def as_json2
    Jbuilder.new do |json|
      json.(self,
        :id,
        :email,
        :firstname,
        :lastname
      )
    end.attributes!
  end
end
