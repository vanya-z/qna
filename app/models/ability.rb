class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, :all
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities
    can :manage, [Question, Answer, Comment], user: user
    can [:accept, :discard], Answer, question: { user: user }
    can [:password, :set_password], User, id: user.id, password_is_set: false
  end
end