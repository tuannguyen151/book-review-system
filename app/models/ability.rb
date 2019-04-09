class Ability
  include CanCan::Ability

  def initialize user
    if user && user.admin?
      can :manage, :all
    elsif user
      can :read, Book
      can :manage, Marker
    else
      can :read, Book
    end
  end
end
