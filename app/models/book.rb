class Book < ApplicationRecord
  belongs_to :category
  has_many :markers, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validate :min_date, :max_date
  validates :title, length: {maximum: Settings.string_maximum}, presence: true
  validates :description, presence: true
  validates :number_pages, presence: true
  validates :price, presence: true
  validates :author, length: {maximum: Settings.name_maximum}, presence: true

  private

  def min_date
    ValidationDate.min_date :publish_date, publish_date
  end

  def max_date
    ValidationDate.max_date :publish_date, publish_date
  end
end
