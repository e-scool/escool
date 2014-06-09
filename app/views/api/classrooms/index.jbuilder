json.classrooms @classrooms do |classroom|
  json.partial! 'api/classrooms/classroom', classroom: classroom
end