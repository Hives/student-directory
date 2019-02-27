# let's put all the students into an array
students = [
  {name: "Dr. Hannibal Lecter", cohort: :november},
  {name: "Darth Vader", cohort: :november},
  {name: "Nurse Ratched", cohort: :november},
  {name: "Michael Corleone", cohort: :november},
  {name: "Alex DeLarge", cohort: :november},
  {name: "The Wicked Witch of the West", cohort: :november},
  {name: "Terminator", cohort: :november},
  {name: "Freddy Krueger", cohort: :november},
  {name: "The Joker", cohort: :november},
  {name: "Joffrey Baratheon", cohort: :november},
  {name: "Norman Bates", cohort: :november}
]
def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end
def print_students(students)
  cohorts = students.map { |student| student[:cohort] }.uniq
  formatted_students = []
  cohorts.each do |cohort|
    students.each_with_index do |student, i|
      if student[:cohort] == cohort
        formatted_students << "#{i+1}: #{student[:name]} (#{student[:cohort]} cohort)" 
      end
    end
  end
  longest_formatted_student = formatted_students.max_by(&:length).length
  formatted_students.each do |formatted_student|
    puts formatted_student.center(longest_formatted_student)
  end
end
def print_footer(names)
  print "Overall, we have #{names.count} great student"
  puts names.count > 1 ? "s" : ""
end
def input_students
  students = []
  loop do
    puts "Enter student name (press enter to finish):"
    name = gets.chomp
    break if name.empty?
    cohort = ""
    loop do
      puts "Enter cohort:"
      cohort = gets.chomp
      break if !cohort.empty?
    end
    students << {name: name, cohort: cohort.to_sym}
    print "Now we have #{students.count} student"
    puts students.count > 1 ? "s" : ""
  end
  students
end
# nothing happens until we call the methods
students = input_students
print_header
print_students(students)
print_footer(students)
