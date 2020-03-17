
cart = Hash.new

loop do
  puts 'Product:'
  product = gets.chomp
  break if product.capitalize == 'Stop'

  puts 'Price:'
  price = gets.chomp.to_i

  puts 'Amount:'
  amount = gets.chomp.to_i

  cart[product] = { price => amount }

end

sum = 0
cart.each do |product, info|
  info.to_a.each { |price, amount| sum += price * amount }
end

puts "Your cart: #{cart}, total sum: #{sum}"