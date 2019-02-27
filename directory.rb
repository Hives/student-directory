@students = []

# let's put all the students into an array
# @students = [
#   {name: "Dr. Hannibal Lecter", cohort: :november},
#   {name: "Darth Vader", cohort: :november},
#   {name: "Nurse Ratched", cohort: :november},
#   {name: "Michael Corleone", cohort: :november},
#   {name: "Alex DeLarge", cohort: :november},
#   {name: "The Wicked Witch of the West", cohort: :november},
#   {name: "Terminator", cohort: :november},
#   {name: "Freddy Krueger", cohort: :november},
#   {name: "The Joker", cohort: :november},
#   {name: "Joffrey Baratheon", cohort: :november},
#   {name: "Norman Bates", cohort: :november}
# ]

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_students_list
  if @students.size > 0
    cohorts = @students.map { |student| student[:cohort] }.uniq
    formatted_students = []
    cohorts.each do |cohort|
      @students.each_with_index do |student, i|
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

def print_footer
  print "Overall, we have #{@students.count} great student"
  puts @students.count == 1 ? "" : "s"
end

def input_students
  loop do
    puts "Enter student name (press enter to finish):"
    name = STDIN.gets.chomp
    break if name.empty?
    cohort = ""
    loop do
      puts "Enter cohort:"
      cohort = STDIN.gets.chomp
      break if !cohort.empty?
    end
    @students << {name: name, cohort: cohort.to_sym}
    print "Now we have #{@students.count} student"
    puts @students.count == 1 ? "" : "s"
  end
  @students
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
  when "1"
    @students = input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
  p @students
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists? filename
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

# nothing happens until we call the methods
try_load_students
interactive_menu
# print_header
# print_students
# print_footer
