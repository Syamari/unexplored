class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :lists, dependent: :destroy

  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validate :password_complexity
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true, presence: true
  validates :user_name, presence: true, length: { maximum: 255 }

  def password_complexity
    return if password.blank? || password =~ /^(?=.*?[a-z])(?=.*?[0-9]).{8,}$/

    errors.add :password, 'は小文字、数字を含む8文字以上である必要があります'
  end
end
