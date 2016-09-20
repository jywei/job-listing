class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    # user ||= User.new # guest user (not logged in)
    if user.blank?
      can :index, Job
      can :show,  Job
      can :index, Company
      can :show,  Company
      cannot :manage, Admin::ApplicationController
    else
      if user.has_role? :admin
        can :manage, :all
      end
      if user.has_role? :seeker
        can :index,       Job
        can :show,        Job
        can :index,       Company
        can :show,        Company
        cannot :index,    Resume
        can :show, Resume do |resume|
          resume.user_id == user.id
        end
        can :dashboard,   Resume
        can :edit,        Resume
        can :update,      Resume
        can :user_update, Resume
        can :getEdu,      Resume
        can :addSch,      Resume
        can :addLan,      Resume
        can :addSki,      Resume
        can :deleEdu,     Resume
        can :getExp,      Resume
        can :addExp,      Resume
        can :addDJS,      Resume
        can :addDJR,      Resume
        can :addDJI,      Resume
        can :deleExp,     Resume
      end
      if user.has_role? :employer
        can :index,  Job
        can :show,   Job
        can :index,  Company
        can :show,   Company
        can :edit,   Company
        can :update, Company
      end
    end
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
