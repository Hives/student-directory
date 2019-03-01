require 'csv'

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

def save_students
  puts 'Enter file to save (hit enter for "students.csv"):'
  filename = STDIN.gets.chomp
  filename = 'students.csv' if filename.empty?
  CSV.open(filename, "wb") do |csv|
    @students.each do |student|
      csv << [student[:name], student[:cohort]]
    end
  end
  puts "Saved students to #{filename}"
end

def load_students
  puts 'Enter file to save (hit enter for "students.csv"):'
  filename = STDIN.gets.chomp
  filename = 'students.csv' if filename.empty?
  load_students_from_file(filename)
end

def load_students_from_file(filename)
  if File.exists? filename
    CSV.foreach(filename) do |row|
      name, cohort = row
      add_student(name, cohort)
    end
    puts "Imported #{filename}"
  else
    puts "Sorry, couldn't find #{filename}"
  end
end

def load_students_if_passed_as_argument
  load_students_from_file(ARGV.first) if !ARGV.empty?
end

# nothing happens until we call the methods
load_students_if_passed_as_argument
interactive_menu
