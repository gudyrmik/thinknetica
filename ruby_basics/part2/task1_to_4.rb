
puts 'Task 1:'
months = { 'Jan': 31, 'Feb': 28, 'Mar': 31, 'Apr': 30, 'May': 31, 'Jun': 30, 'Jul': 31, 'Aug': 31, 'Sep': 30, 'Oct': 31, 'Nov': 30, 'Dec': 31 }
months.each { |k, v| print k.to_s + ' ' if v == 30 }
puts

puts 'Task 2:'
arr = (10..100).step(5).to_a
puts "#{arr}"

puts 'Task 3:'
fibo = [0, 1]
while fibo.last < 100
  fibo.push(fibo[-1] + fibo[-2])
end
puts "#{fibo}"

puts 'Task 4: (не уверен, что правильно понял задачку)'
alfa = ('a'..'z').to_a
vowels_arr = ['a', 'e', 'i', 'o', 'u']
vowels_hash = Hash.new
vowels_arr.each { |v| vowels_hash[v] = alfa.index(v) }
puts "#{vowels_hash}"