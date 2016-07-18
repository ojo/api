class User < ApplicationRecord
  has_and_belongs_to_many :roles
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :lockable, :timeoutable, :confirmable

  def has_role? role_name
    not self.roles.where(name: role_name).empty?
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
