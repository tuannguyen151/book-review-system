class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :comments, as: :commentable, dependent: :destroy
end
