class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  has_many :permissions, class_name: "UserProjectPermission"
  has_many :projects, through: :permissions

  def as_json(opts = {})
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
