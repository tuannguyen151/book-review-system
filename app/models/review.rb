class Review < ApplicationRecord
  REVIEW_PARAMS = %i(rate content).freeze

  belongs_to :user
  belongs_to :book
  has_many :comments, as: :commentable, dependent: :destroy

  validates_uniqueness_of :user_id, scope: :book_id
  validates :rate, presence: true
  validates :content, presence: true

  scope :updated_at_desc, ->{order updated_at: :desc}
  scope :move_review_of_user_to_top, (lambda do |user|
    order Arel.sql("CASE user_id WHEN #{user.id} THEN 0 ELSE 1 END")
  end)
end
