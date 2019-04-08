class Book < ApplicationRecord
  AUTHORIZE_ADMIN = %w(update delete).freeze

  belongs_to :category
  has_many :markers, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validate :min_date, :max_date
  validates :publish_date, presence: true
  validates :title, length: {maximum: Settings.string_maximum}, presence: true
  validates :description, presence: true
  validates :number_pages, presence: true
  validates :price, presence: true
  validates :author, length: {maximum: Settings.name_maximum}, presence: true

  mount_uploader :cover_image, CoverImageUploader

  private

  def min_date
    ValidationDate.min_date self, :publish_date, publish_date
  end

  def max_date
    ValidationDate.max_date self, :publish_date, publish_date
  end
end
