
puts "Enter coeff 'a'"
a = gets.chomp.to_i

puts "Enter coeff 'b'"
b = gets.chomp.to_i

puts "Enter coeff 'c'"
c = gets.chomp.to_i

D = b ** 2 - 4 * a * c

if D > 0
  x1 = (-b + Math.sqrt(D)) / (2 * a)
  x2 = (-b - Math.sqrt(D)) / (2 * a)
  puts "D = #{D}, x1 = #{x1}, x2 = #{x2}"
end

if D == 0
  x = -b / (2 * a)
  puts "D = #{D}, x = #{x}"
end

if D < 0
  puts "Equation doesn't have roots in R set."
end