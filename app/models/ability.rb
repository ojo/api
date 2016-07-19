class Ability
  include CanCan::Ability

  def initialize(user)
    # WARNING!
    # ========
    # Do not attempt to use the line below. Users who are not logged in
    # should not have access to any functions inside the application.
    # user ||= User.new # guest user (not logged in)
    # - brianhc

    if user.has_role? :news
      can :manage, NewsItem
    end


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
    if user.confirmed? and ['brian.holderchow@gmail.com', 'brian@ttrn.org'].include? user.email
      can :manage, Role
    end
    if user.has_role? :superadmin # last because it must override
      can :manage, :all
    end
  end
end
