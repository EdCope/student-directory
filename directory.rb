@students = [] # an empty array accessible by all methods

def input_students
  puts "Please enter the names of new students"
  puts "To finish, press return twice"

  name = STDIN.gets.gsub("\n", "")
  
  # waits until name variable is empty to trigger double return exit
  while !name.empty? do
    add_student(name, input_cohort)
    puts plural?("Now we have #{@students.count} student")
    puts "Enter another name or press Return to complete"
    name = STDIN.gets.gsub("\n", "")
  end

end

def input_cohort
  months = [
      "January", "February", "March", "April", "May",
      "June", "July", "August", "September", "October",
      "November", "December"
    ]

  puts "Assign student to a cohort (If empty will be assigned to the current cohort)"
  cohort = STDIN.gets.gsub("\n", "")
  while true do
    if cohort.empty?
      cohort = months[0] # current month
      puts "Assigned to #{months[0]} cohort."
      return cohort.to_sym
    else
      cohort.capitalize!
      if months.include?(cohort)
        puts "Assigned to #{cohort} cohort."
        return cohort.to_sym
      else
        puts "Try again - not a valid Cohort"
        cohort = STDIN.gets.gsub("\n", "")
      end

    end

  end

end

def add_student(name = "value", cohort = "value", dob = "value", height = "value", hobbies = "value")
  @students << {name: name, cohort: cohort, dob: dob, height: height, hobbies: hobbies}
end

def plural?(string)
  @students.count == 1 ? string : (string + "s")
end

def print_header
  puts "The students of the Villains Academy"
  puts "------------------------------------"
end

def print_body
  if @students.count < 1
    puts "There are no students enrolled at the Villains Academy"
    return
  end
  print_student_elements(@students.map { |student| student[:cohort] }.uniq)
end

def print_student_elements(cohorts)
  cohorts.each do |cohort|
    puts "Cohort #{cohort}"
    puts "------------------------------------"
    @students.each_with_index do |student, idx|
      if student[:cohort] == cohort
        puts "#{idx + 1}. " + "#{student[:name]}".center(12) + " (#{student[:cohort]} cohort)"
        puts "------------------------------------"
        puts "    DOB: " + "#{student[:dob]}".center(12)
        puts " Height: " + "#{student[:height]}".center(12)
        puts "Hobbies: " + "#{student[:hobbies]}".center(12)
        puts "------------------------------------"
      end

    end

  end

end

def print_footer
  if @students.count > 1
    puts plural?("Overall, we have #{@students.count} great student")
  end

end

def show_students
  print_header
  print_body
  print_footer
end

def save_students(filename = "students.csv")
  File.open(filename, "w") do |file|
    @students.each do |student|
      student_data = [student[:name], student[:cohort],
      student[:dob], student[:height], student[:hobbies]]
      csv_line = student_data.join(",") + "\n"
      file << csv_line
    end
    puts "Saved the student list to #{filename}"
  end

end

def load_students(filename = "students.csv")
  File.open(filename, "r") do |file|
    file.readlines.each do |line|
      name, cohort, dob, height, hobbies = line.chomp.split(",")
      add_student(name, cohort.to_sym, dob, height, hobbies)
    end
    puts "Loaded #{@students.count} students from #{filename}"
  end
  
end

def try_load_students
  filename = ARGV.first
  return load_students if filename.nil?
  if File.exist?(filename)
    load_students(filename)
  else
    puts "Sorry, #{filename} doesn't exist."
  end

end

def menu_choice(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    puts "Where would you like to save the list to? (Default: students.csv)"
    input = STDIN.gets.chomp
    save_students(input.empty? ? "students.csv" : input)
  when "4"
    puts "Which list would you like to load? (Default: students.csv)"
    input = STDIN.gets.chomp
    load_students(input.empty? ? "students.csv" : input)
  when "9"
    puts "Goodbye!"
    exit
  else
    puts "I don't know what you meant, try again"
  end

end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to csv"
  puts "4. Load the list from csv"
  puts "9. Exit"
end

def interactive_menu
  try_load_students
  loop do
    print_menu
    menu_choice(STDIN.gets.chomp)

  end

end

interactive_menu
