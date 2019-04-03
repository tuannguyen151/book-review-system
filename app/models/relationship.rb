class Relationship < ApplicationRecord
  belongs_to :followed, class_name: User.name
  belongs_to :follower, class_name: User.name
  has_one :activity, as: :activitable, dependent: :destroy

  validates :follower_id, presence: true
  validates :followed_id, presence: true

  after_create :create_activities

  private

  def create_activities
    create_activity user: follower
  end
end
