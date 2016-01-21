class StaticPagesController < ApplicationController
  def about
    add_crumb 'About'
  end

  def return_policy
    add_crumb 'Return Policy'
  end

  def refer_friends
    add_crumb 'Refer Friends'
  end

end
