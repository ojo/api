class User < ApplicationRecord
  # Others available are: :confirmable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :lockable, :timeoutable
end
