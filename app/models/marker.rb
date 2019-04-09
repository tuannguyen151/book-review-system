class Marker < ApplicationRecord
  AUTHORIZE_USER = %w(create delete).freeze

  enum status: {favorite: 1, readed: 2, reading: 3, purchase_request: 4,
                rate_and_review: 5}

  belongs_to :user
  belongs_to :book
  has_one :activity, as: :activitable, dependent: :destroy

  validates :status, uniqueness: {scope: %i(user_id book_id)}

  after_create :create_activities

  scope :created_at_desc, ->{order created_at: :desc}

  private

  def create_activities
    create_activity user: user
  end
end
