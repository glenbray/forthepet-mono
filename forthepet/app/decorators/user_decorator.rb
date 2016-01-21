class UserDecorator < BaseDecorator
  def name
    object.full_name.nil? ?  "You haven't set your name." : object.full_name
  end
end
