# encoding: utf-8

password = 'cool2013es'

puts "=> Creating AdminUser (email: 'admin@e-scool.com', password: 'cool2013es')"
# Create AdminUser
AdminUser.create!(email: 'admin@e-scool.com', password: password, password_confirmation: password)

puts '=> Creating School'
# Create School
school = School.create(name: 'Test School')

puts '=> Creating ClassroomTypes'
# Create ClassroomTypes
type1 = school.classroom_types.create(name: "Llar d'Infants",            materials: true, communications: true, daily_activities: true, lunch_reports: true)
type2 = school.classroom_types.create(name: "Primària - Cicle Infantil", materials: true, communications: true, daily_activities: false, lunch_reports: false)
type3 = school.classroom_types.create(name: "Primària - Cicle Superior", materials: true, communications: true, daily_activities: false, lunch_reports: false)

puts '=> Creating Classrooms'
# Create Classrooms
classroom1 = school.classrooms.create(name: 'P3',   classroom_type: type1)
classroom2 = school.classrooms.create(name: 'P4',   classroom_type: type2)
classroom3 = school.classrooms.create(name: 'P5',   classroom_type: type2)
classroom4 = school.classrooms.create(name: '1r A', classroom_type: type3)
classroom5 = school.classrooms.create(name: '1r B', classroom_type: type3)
classroom6 = school.classrooms.create(name: '2n A', classroom_type: type3)
classroom7 = school.classrooms.create(name: '2n B', classroom_type: type3)

puts '=> Creating Teachers & Subjects'
# Create Teachers & Subjects
subjects = ['Mates', 'Ciències', 'Anglès', 'Català', 'Castellà']
teacher_count = 1
assigned_teachers = []
school.classrooms.each do |classroom|
  subjects.each do |subject|
    teacher = school.teachers.find_or_create_by_username("profe#{teacher_count}") do |t|
      t.name = "Profe #{teacher_count}"
      t.email = "profe#{teacher_count}@profes.com"
      t.password = password
      t.password_confirmation = password
    end
    classroom.subjects.create!(name: subject, teacher: teacher)
    teacher.update_attributes(classrooms: teacher.classrooms << classroom)
    if assigned_teachers.count < 10 # School will have 10 Teachers
      assigned_teachers << teacher
      teacher_count += 1
    else
      assigned_teachers = []
      teacher_count = 1
    end
  end
end

puts '=> Creating Parents'
# Create Parents
for i in 1..100
	school.parents.create!(name: "Pares #{i}", username: "pares#{i}", email: "pares#{i}@pares.com", password: password, password_confirmation: password)
end

puts '=> Creating Children'
# Create 140 Children
classroom_count = 1
parent_count = 1
for i in 1..140
	school.children.create!(name: "Nen #{i}", classroom: eval("classroom#{classroom_count}"), parent: Parent.find_by_username("pares#{parent_count}"))
	classroom_count == 7 ? classroom_count = 1 : classroom_count += 1
	parent_count == 100 ? parent_count = 1 : parent_count += 1
end
