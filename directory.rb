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
  if students.size > 0
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
end

def print_footer(names)
  print "Overall, we have #{names.count} great student"
  puts names.count == 1 ? "" : "s"
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
    puts students.count == 1 ? "" : "s"
  end
  students
end

def interactive_menu
  students = []
  loop do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit"
    selection = gets.chomp
    case selection
    when "1"
      students = input_students
    when "2"
      print_header
      print_students(students)
      print_footer(students)
    when "9"
      exit
    else
      puts "I don't know what you meant, try again"
    end
  end
end

# nothing happens until we call the methods
interactive_menu
print_header
print_students(students)
print_footer(students)
