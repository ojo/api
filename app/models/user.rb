class User < ApplicationRecord
  # Others available are: :confirmable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :lockable, :timeoutable

  def is_admin?
    # TODO
    self.email == 'brian.holderchow@gmail.com'
  end
end
