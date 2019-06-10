class User < ApplicationRecord
  USER_PARAMS = %i(email password).freeze
  has_one :user_profile, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed,
    dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :markers
  has_many :reviews, dependent: :destroy
  has_many :comments
  has_many :likes
  has_many :activities

  scope :order_id_desc, ->{order id: :desc}
  scope :by_user_profile_name, (lambda do |name|
    eager_load(:user_profile).where "name LIKE ?", "%#{name}%"
  end)
  devise :database_authenticatable, :registerable, :confirmable, :lockable,
    :recoverable, :rememberable, :validatable
  acts_as_token_authenticatable
  accepts_nested_attributes_for :user_profile

  def recent_activities limit
    activities.order("created_at DESC").limit limit
  end

  def reset_authentication_token!
    update_column :authentication_token, Devise.friendly_token
  end
end
