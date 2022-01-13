def input_students
  puts "Please enter the names of new students"
  puts "To finish, press return twice"
  students = []
  name = gets.chomp
  # waits until name variable is empty to trigger double return exit
  while !name.empty? do
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end
  students
end

def print_header
  puts "The students of the Villains Academy"
  puts "-----------------"
end

def print(students)

  students.each_with_index do |student, i|
    puts "#{i + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

students = input_students
print_header
print(students)
print_footer(students)
