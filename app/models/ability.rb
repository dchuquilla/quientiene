# frozen_string_literal: true

# Defines user permissions according to roles
class Ability
  include CanCan::Ability

  def initialize(user)
    customer_abilities(user) if user.has_role?(:customer)
    shop_abilities(user) if user.has_role?(:shop)
    can :manage, :all if user.has_role?(:administrator)
  end

  def customer_abilities(user)
    # Customer permissions
    can :manage, Vehicle, user: user
    can :manage, ReplacementRequest, user: user
    can :read, ReplacementProposal
    can :ignore, ReplacementProposal
    can :accept, ReplacementProposal
  end

  def shop_abilities(user)
    can :read, ReplacementRequest
    can :ignore, ReplacementRequest
    can :manage, Shop, user: user
    can :manage, ReplacementProposal, user: user
    can :manage, IgnoredRequest
  end
end
