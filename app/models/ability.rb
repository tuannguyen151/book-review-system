class Ability
  include CanCan::Ability

  def initialize user
    if user && user.admin?
      can :manage, :all
    elsif user
      can :read, Book
      can :manage, Marker
      can :read, UserProfile
      can %i(create update), UserProfile, user_id: user.id
      can %i(create destroy), Relationship
    else
      can :read, Book
      can :read, UserProfile
    end
  end
end
