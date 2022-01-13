def input_students
  students = []

  puts "Please enter the names of new students"
  puts "To finish, press return twice"

  name = gets.gsub("\n", "")
  months = [
      "January", "February", "March", "April", "May",
      "June", "July", "August", "September", "October",
      "November", "December"
    ]

  # waits until name variable is empty to trigger double return exit
  counter = 0
  while !name.empty? do
    students << {name: name, dob: "value", height: "value", hobbies: "value"}
    plural = "Now we have #{students.count} student"
    puts students.count == 1 ? plural : (plural + "s")
    puts "Assign student to a cohort (If empty will be assigned to the current cohort)"

    # Handle Assignment of cohort
    cohort = gets.gsub("\n", "")
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
          cohort = gets.gsub("\n", "")
        end

      end

    end
    # count the students to avoid additional loops
    counter += 1
    puts "Enter another name or press Return to complete"
    name = gets.gsub("\n", "")
  end

  students
end

def print_header
  puts "The students of the Villains Academy"
  puts "------------------------------------"
end

def print(students)
  if students.count < 1
    puts "There are no students enrolled at the Villains Academy"
    return
  end
  cohorts = students.map { |student| student[:cohort] }.uniq
  cohorts.each do |cohort|
    puts "Cohort #{cohort}"
    puts "------------------------------------"
    students.each_with_index do |student, idx|
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

def print_footer(students)
  if students.count > 1
    plural = "Overall, we have #{students.count} great student"
    puts students.count == 1 ? plural : (plural + "s")
  end
end

students = input_students
print_header
print(students)
print_footer(students)
