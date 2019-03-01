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
    @students.each do |student|
      puts "#{student[:name]} (#{student[:cohort]} cohort)" 
    end
  end
  puts "-------------"
end

def print_footer
  print "Overall, we have #{@students.count} great student"
  puts @students.count == 1 ? "" : "s"
end

def print_menu
  puts
  puts "1. Input students"
  puts "2. Show the students"
  puts "3. Save the list"
  puts "4. Load a list from a file"
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
    input = STDIN.gets.chomp
    puts
    process(input)
  end
end

def save_students
  puts 'Enter file to save (hit enter for "students.csv"):'
  filename = STDIN.gets.chomp
  filename = 'students.csv' if filename.empty?
  file = File.open(filename, "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  puts "Saved students to #{filename}"
  file.close
end

def add_student(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
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
    add_student(name, cohort)
    print "Now we have #{@students.count} student"
    puts @students.count == 1 ? "" : "s"
  end
  @students
end

def get_file_to_load(filename = nil)
  if filename == nil
    puts 'Enter file to load (hit enter for "students.csv"):'
    filename = STDIN.gets.chomp
    filename = 'students.csv' if filename.empty?
  end
  if File.exists? filename
    file = File.open(filename, "r")
    return file
  else
    puts "Sorry, couldn't find #{filename}."
    return false
  end
end

def load_students(filename = "students.csv")
  file = get_file_to_load
  unless file == false
    file.readlines.each do |line|
      name, cohort = line.chomp.split(',')
      add_student(name, cohort)
    end
    file.close
    puts "Imported #{File.basename(file.path)}."
  end
end

def try_load_students
  if ARGV.empty?
    filename = "students.csv"
  else
    filename = ARGV.first
  end
  load_students(get_file_to_load(filename))
end

# nothing happens until we call the methods
try_load_students
interactive_menu
# print_header
# print_students
# print_footer
