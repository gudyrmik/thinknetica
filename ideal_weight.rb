
puts 'Enter your name:'
name = gets.chomp

puts 'Enter your height:'
height = gets.chomp.to_i

ideal_weight = 1.15 * (height - 110)

if ideal_weight < 0
  puts 'Your weight is already optimal.'
else
  puts "#{name}, your ideal weight is around #{ideal_weight.round} kg."
end