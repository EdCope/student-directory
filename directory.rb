def input_students
  students = []

  puts "Please enter the names of new students"
  puts "To finish, press return twice"

  name = gets.chomp
  months = [
      "January", "February", "March", "April", "May",
      "June", "July", "August", "September", "October",
      "November", "December"
    ]

  # waits until name variable is empty to trigger double return exit
  counter = 0
  while !name.empty? do
    students << {name: name, dob: "value", height: "value", hobbies: "value"}
    puts "Now we have #{students.count} students"
    puts "Assign student to a cohort (If empty will be assigned to the current cohort)"

    # Handle Assignment of cohort
    cohort = gets.chomp
    while true do
      if cohort.empty?
        cohort = months[0] # current month
        puts "Assigned to #{months[0]} cohort."
        students[counter][:cohort] = cohort.to_sym
        break
      else
        cohort.capitalize!
        if months.include?(cohort)
          puts "Assigned to #{cohort} cohort."
          students[counter][:cohort] = cohort.to_sym
          break
        else
          puts "Try again - not a valid Cohort"
          cohort = gets.chomp
        end
      end
    end
    puts students[counter]
    # count the students to avoid additional loops
    counter += 1
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
      puts "------------------------------------"
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
