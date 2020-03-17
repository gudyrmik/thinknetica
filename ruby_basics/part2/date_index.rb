
puts 'Enter day'
day = gets.chomp.to_i
return if day > 31 || day < 0

puts 'Enter month'
month = gets.chomp.to_i
return if month > 12 || month < 0

puts 'Enter year'
year = gets.chomp.to_i
return if year > 10000 || year < 0

days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

is_leap = false
is_leap = true if year % 4 == 0 && year % 100 != 0
is_leap = true if year % 400 == 0

date_index = 0
date_index += 1 if is_leap == true

iteration = 1
days.each do |d|
  date_index += d if iteration < month
  date_index += day if iteration == month
  break if iteration > month
  iteration += 1
end

puts "Date index: #{date_index}"