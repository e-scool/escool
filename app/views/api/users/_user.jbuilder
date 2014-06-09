json.cache! user do
  json.id            user.id
  json.type          user.type
  json.name          user.name
  json.username      user.username
  json.child_ids     user.becomes(Parent).children.pluck(:id)
  json.classroom_ids user.becomes(Teacher).classrooms.pluck(:id)
end

# Private fields
# if is_parent
#   json.current_child_id     user.current_child_id
# else
#   json.current_classroom_id user.current_classroom_id
# end