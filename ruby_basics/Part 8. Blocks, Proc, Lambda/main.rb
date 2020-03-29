require_relative 'train.rb'
require_relative 'route.rb'
require_relative 'station.rb'
require_relative 'car.rb'

s1 = Station.new('Prague')
s2 = Station.new('Brno')
t1 = CargoTrain.new('111-AB')
r1 = Route.new(s1, s2)
t1.add_car(Car.new(:cargo, 100))
t1.add_car(Car.new(:cargo, 10))
t1.assign_route(r1)

# Не уверен что правильно понял это задание, пинайте:)

puts 'Printing station:'
s1.task8_method { |train| puts train.to_s }

puts 'Printing train:'
t1.iterate_cars { |car| puts car.to_s}
