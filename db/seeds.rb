# encoding: utf-8

# Set password
password = 'cool2013es'

# Create AdminUser
puts "=> Creating AdminUser (email: 'admin@e-scool.com', password: 'cool2013es')"
AdminUser.create!(email: 'admin@e-scool.com', password: password, password_confirmation: password)

# Create School
puts '=> Creating School'
school = School.create(name: 'Test School')

# Create ClassroomTypes
puts '=> Creating ClassroomTypes'
type1 = school.classroom_types.create(name: "Llar d'Infants",            materials: true, communications: true, daily_activities: true, lunch_reports: true)
type2 = school.classroom_types.create(name: "Primària - Cicle Infantil", materials: true, communications: true, daily_activities: false, lunch_reports: false)
type3 = school.classroom_types.create(name: "Primària - Cicle Superior", materials: true, communications: true, daily_activities: false, lunch_reports: false)

# Create Classrooms
puts '=> Creating Classrooms'
classroom1 = school.classrooms.create(name: 'P3',   classroom_type: type1)
classroom2 = school.classrooms.create(name: 'P4',   classroom_type: type2)
classroom3 = school.classrooms.create(name: 'P5',   classroom_type: type2)
classroom4 = school.classrooms.create(name: '1r A', classroom_type: type3)
classroom5 = school.classrooms.create(name: '1r B', classroom_type: type3)
classroom6 = school.classrooms.create(name: '2n A', classroom_type: type3)
classroom7 = school.classrooms.create(name: '2n B', classroom_type: type3)

# Create Teachers (10) & Subjects (5 per Classroom)
puts '=> Creating Teachers & Subjects'
subjects = ['Mates', 'Ciències', 'Anglès', 'Català', 'Castellà']
teacher_id = rand(1..10)
assigned_teachers_ids = []
school.classrooms.each do |classroom|
  subjects.each do |subject|
    teacher = school.teachers.find_or_create_by_username("profe#{teacher_id}") do |t|
      t.name = "Profe #{teacher_id}"
      t.email = "profe#{teacher_id}@profes.com"
      t.password = password
      t.password_confirmation = password
    end
    classroom.subjects.create!(name: subject, teacher: teacher)
    teacher.update_attributes(classrooms: teacher.classrooms << classroom)
    assigned_teachers_ids << teacher_id
    if assigned_teachers_ids.count < 10
      teacher_id = ([*1..10] - assigned_teachers_ids).sample
    else
      assigned_teachers_ids = []
      teacher_id = rand(1..10)
    end
  end
end

# Create 100 Parents
puts '=> Creating Parents'
for i in 1..100
	school.parents.create!(name: "Pares #{i}", username: "pares#{i}", email: "pares#{i}@pares.com", password: password, password_confirmation: password)
end

# Create 140 Children
puts '=> Creating Children'
classroom_count = 1
parent_count = 1
for i in 1..140
	school.children.create!(name: "Nen #{i}", classroom: eval("classroom#{classroom_count}"), parent: Parent.find_by_username("pares#{parent_count}"))
	classroom_count >= 7 ? classroom_count = 1 : classroom_count += 1
	parent_count >= 100 ? parent_count = 1 : parent_count += 1
end

# Create Communications and Materials
puts '=> Creating Communications and Materials'
parent = Parent.find_by_username('pares1')
parent.children.each do |c|
  communication_attrs = {
    classroom: c.classroom,
    children: c.classroom.children.all,
    subject: c.classroom.subjects.first,
    title: "El proper cap de setmana sortim de festa!",
    body: "Ho heu sentit bé, el proper dissabte marxem tota l'escola plegats de festa en motiu del centenari del centre. Party hard!",
    date: 2.months.from_now
  }

  material_attrs = {
    classroom: c.classroom,
    children: c.classroom.children.all,
    subject: c.classroom.subjects.first,
    title: "Llibres Escolars",
    body: "Ho heu sentit bé, el proper dissabte marxem tota l'escola plegats de festa en motiu del centenari del centre. Party hard!",
    date: 2.months.from_now
  }

  10.times do
    Communication.create!(communication_attrs)
    Material.create!(material_attrs)
  end
end

