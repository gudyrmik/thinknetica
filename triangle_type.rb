
puts "Enter side A length:"
a = gets.chomp.to_i

puts "Enter side B length:"
b = gets.chomp.to_i

puts "Enter side C length:"
c = gets.chomp.to_i

valid = (a > 0 && b > 0 && c > 0)

equilateral = (a == b && b == c && valid)
isosceles = (equilateral || ((a == b || a == c || b == c) && valid))

right = false
if !isosceles && !equilateral && valid
	triangle = [a, b, c].sort
	right = (triangle[2] ** 2 == triangle[1] ** 2 + triangle[0] ** 2)
end

answer = ""
if equilateral
	answer += "equilateral."
end
if isosceles
	answer += "isosceles."
end
if right
	answer += "right."
end

if answer.empty?
	answer += "regular."
end

puts "Your triangle is #{answer}."