if @tutors.present?
  json.tutors @tutors.each do |tutor|
      json.name tutor.user.name
  end
elsif @students.present?
    json.students @students.each do |student|
       json.name student.user.name
    end
end
