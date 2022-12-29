class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  has_many :permissions, class_name: "UserProjectPermission"
  has_many :projects, through: :permissions
  has_many :admin_projects, class_name: "Project", inverse_of: :owner, foreign_key: :owner_id

  def fullname
    [firstname, lastname].compact.join(" ")
  end

  def as_json(opts = {})
    Jbuilder.new do |json|
      json.(self,
        :id,
        :email,
        :firstname,
        :lastname,
        :fullname,
      )
    end.attributes!
  end
end
