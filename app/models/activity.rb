class Activity < ApplicationRecord
  belongs_to :activitable, polymorphic: true
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, dependent: :destroy
end
