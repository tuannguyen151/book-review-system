class Activity < ApplicationRecord
  belongs_to :activitable, polymorphic: true
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, dependent: :destroy

  scope :where_user, ->(users){where user_id: users}
  scope :markers, ->{where activitable_type: Marker.name}
  scope :relationships, ->{where activitable_type: Relationship.name}
end
