
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
days[1] = 29 if year % 400 == 0 && (year % 4 == 0 && year % 100 == 0)

date_index = days.take(month - 1).sum +  day

puts "Date index: #{date_index}"