class ManagedTwitterAccount < ApplicationRecord
  has_many :tweets
  validates_uniqueness_of :username
end
