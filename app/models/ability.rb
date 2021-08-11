# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)

    # Customer permissions
    if user.has_role?(:customer)
      can :manage, Vehicle, user: user
      can :manage, ReplacementRequest, user: user
      can :read, ReplacementProposal
      can :ignore, ReplacementProposal
    end

    # Shop Permissions
    if user.has_role?(:shop)
      can :read, ReplacementRequest
      can :ignore, ReplacementRequest
      can :manage, Shop, user: user
      can :manage, ReplacementProposal, user: user
      can :manage, IgnoredRequest
    end

    if user.has_role?(:administrator)
      can :manage, :all
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
