def input_students
  puts "Please enter the names of new students"
  puts "To finish, press return twice"
  students = []
  name = gets.chomp
  # waits until name variable is empty to trigger double return exit
  while !name.empty? do
    students << {name: name, cohort: :november, dob: "value", height: "value", hobbies: "value"}
    puts "Now we have #{students.count} students"
    name = gets.chomp
    
  end
  students
end

def print_header
  puts "The students of the Villains Academy"
  puts "------------------------------------"
end

def print(students)
  idx = 0
  until idx == students.length
    student = students[idx]
    if student[:name][0] == "J" && student[:name].length <= 12
      puts "#{idx + 1}. " + "#{student[:name]}".center(12) + " (#{student[:cohort]} cohort)"
      puts "------------------------------------"
      puts "    DOB: " + "#{student[:dob]}".center(12)
      puts " Height: " + "#{student[:height]}".center(12)
      puts "Hobbies: " + "#{student[:hobbies]}".center(12)
    end
    idx +=1
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

students = input_students
print_header
print(students)
print_footer(students)
