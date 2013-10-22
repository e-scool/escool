# Public: A decorator for a User. Adds helper methods to be used in the
# views or other representations.
#
# Example:
#   UserDecorator.new(user)
#   user.decorate
#
# Example to decorate a collection:
#   UserDecorator.decorate_collection(users)
#
class UserDecorator < Draper::Decorator
  delegate_all

end
