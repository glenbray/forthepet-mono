class Ability
  include CanCan::Ability

  def initialize(admin)
    if admin
      if admin.is?(:god)
        can :manage, :all
      else
        can :manage, Order if admin.is?(:orders)
        can :manage, Deal if admin.is?(:deals)
        can :manage, Product if admin.is?(:products)
        can :manage, Category if admin.is?(:categories)
        can :manage, Supplier if admin.is?(:suppliers)
        can :manage, User if admin.is?(:users)
        can :manage, Admin if admin.is?(:admins)
      end
    end
  end
end
