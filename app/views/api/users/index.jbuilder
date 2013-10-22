json.users do
  json.array! @users do |user|
    json.partial! user, is_parent: user.parent?
  end
end