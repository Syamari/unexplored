class User < ApplicationRecord
  before_validation :set_username_from_email, on: :create
  authenticates_with_sorcery!

  has_many :lists, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_lists, through: :bookmarks, source: :list
  has_many :authentications, dependent: :destroy

  accepts_nested_attributes_for :authentications

  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validate :password_complexity
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true

  validates :email, uniqueness: true, presence: true
  validates :user_name, presence: true, length: { maximum: 255 }

  def password_complexity
    return if password.blank? || password =~ /^(?=.*?[a-z])(?=.*?[0-9]).{8,}$/

    errors.add :password, 'は小文字、数字を含む8文字以上である必要があります'
  end

  private

  def set_username_from_email
    self.user_name = self.email.split('@').first if email.present?
  end
end
