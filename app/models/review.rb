class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :comments, as: :commentable, dependent: :destroy
  validates_uniqueness_of :user_id, scope: :book_id
  scope :order_desc, ->{order created_at: :desc}
end
