class Category < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, length: {maximum: Settings.name_maximum}, presence: true
end
