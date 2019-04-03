class Marker < ApplicationRecord
  enum status: {favorite: 1, readed: 2, reading: 3, purchase_request: 4,
                rate_and_review: 5}

  belongs_to :user
  belongs_to :book
  has_one :activity, as: :activitable, dependent: :destroy

  after_create :create_activities

  private

  def create_activities
    create_activity user: user
  end
end
