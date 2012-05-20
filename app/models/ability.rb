class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    else
      can :manage, :all, :user_id => user.id
      can :manage, :all, :_id => user.id
      can :read, :all
    end

  end
end
