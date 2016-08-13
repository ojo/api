class Role < ApplicationRecord
  has_and_belongs_to_many :users

  VALID_ROLES = %w[staff news superadmin].freeze

  validates_presence_of :name
  validates_uniqueness_of :name

  def self.role_names
    VALID_ROLES
  end
end
