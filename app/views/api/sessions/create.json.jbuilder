json.token @user.authentication_token
json.user_id @user.id

json.children @user.children do |child|
  json.partial! 'api/children/child', child: child
end