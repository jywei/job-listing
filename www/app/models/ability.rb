class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    # user ||= User.new # guest user (not logged in)
    if user.blank?
      can [:index, :show], Job
      can [:index, :show], Company
      # cannot :read, JobFilter
    else
      unless user.has_any_role?
        can [:new, :create], Resume
        can [:new, :create], Company
      end
      if user.has_role? :admin
        can :manage, :all
      end
      if user.has_role? :seeker
        can [:index, :show, :new_cover_letter, :show_cover_letter, :favorite_job, :unfollow_job], Job
        can [:index, :show, :save_to_favorites, :unlike],     Company
        cannot :index,           Resume
        can [:show, :edit, :update],    Resume do |resume|
          resume.user_id == user.id
        end
        can [:user_update, :getEdu, :addSch, :addLan, :addSki, :deleEdu,
             :getExp, :addExp, :addDJS, :addDJR, :addDJI, :deleExp,
             :dashboard, :education, :experience], Resume
      end
      if user.has_role? :employer
        cannot :new_cover_letter, Job
        can [:index, :show, :new, :create, :show_cover_letter], Job
        can [:edit, :update, :destroy], Job do |job|
          job.company == user.company
        end
        can [:index, :show],  Company
        can [:edit, :update], Company do |company|
          company == user.company
        end
        can [:index, :show, :favorite_resume, :unfollow_resume], Resume
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
