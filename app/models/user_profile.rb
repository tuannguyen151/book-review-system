class UserProfile < ApplicationRecord
  USER_PROFILE_PARAMS = %i(avatar_url name gender birthday phone address).freeze
  enum gender: {female: 0, male: 1}

  belongs_to :user

  validate :min_date, :max_date
  validates :gender, presence: true
  validates :name, presence: true, length: {maximum: Settings.name_maximum},
    uniqueness: true
  validates :address, length: {maximum: Settings.string_maximum},
    allow_nil: true
  validates :phone, length: {maximum: Settings.string_maximum},
    allow_blank: true,
      format: {with: /\A\d+\z/, message: I18n.t("activerecord.number")}

  mount_uploader :avatar_url, AvatarUrlUploader

  private

  def min_date
    ValidationDate.min_date self, :birthday, birthday
  end

  def max_date
    ValidationDate.max_date self, :birthday, birthday
  end
end
