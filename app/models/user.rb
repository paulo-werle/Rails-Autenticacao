# frozen_string_literal: true

class User < ApplicationRecord
  # Devise
  # Outras opções são :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise(:database_authenticatable, :registerable, :recoverable, :rememberable, :validatable)

  # Associations
  has_many(
    :access_grants,
    class_name: 'Doorkeeper::AccessGrant',
    foreign_key: :resource_owner_id,
    dependent: :delete_all,
    inverse_of: false
  )

  has_many(
    :access_tokens,
    class_name: 'Doorkeeper::AccessToken',
    foreign_key: :resource_owner_id,
    dependent: :delete_all,
    inverse_of: false
  )

  has_many(:user_roles,       dependent: :destroy)
  has_many(:roles,            through: :user_roles)
  has_many(:role_permissions, through: :roles)
  has_many(:permissions,      through: :role_permissions)

  # Callbacks
  # Enums
  # Methods
  # Scope
  # Validates
end
