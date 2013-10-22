json.user do
  json.partial! @user, is_parent: @user.parent?
end