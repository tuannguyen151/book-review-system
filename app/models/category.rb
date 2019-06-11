class Category < ApplicationRecord
  CATEGORY_PARAMS = %i(name).freeze

  has_many :books, dependent: :destroy

  validates :name, length: {maximum: Settings.name_maximum}, presence: true,
    uniqueness: true
end
