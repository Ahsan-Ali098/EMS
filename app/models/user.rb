# frozen_string_literal: true

# Users Model
class User < ApplicationRecord
  paginates_per 5
  attr_writer :login

  enum role: %i[client admin]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, authentication_keys: [:login]

  PASSWORD_FORMAT = /\A
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  (?=.*[[:^alnum:]]) # Must contain a symbol
/x.freeze

  validates :password,
            presence: true,
            format: { with: PASSWORD_FORMAT }, on: :create

  validates :user_name, presence: true
  validates :email, presence: true
  validates :password, confirmation: { case_sensitive: true }

  def login
    @login || user_name || email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(['lower(user_name) = :value OR lower(email) = :value',
                                    { value: login.downcase }]).first
    elsif conditions.key?(:user_name) || conditions.key?(:email)
      where(conditions.to_h).first
    end
  end

  def self.search_user(search)
    User.where('cast(id as text) LIKE :value or lower(users.user_name) LIKE :value or lower(users.email) LIKE :value ',
               value: "%#{search.downcase}%")
  end
end
