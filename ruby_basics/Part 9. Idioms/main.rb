require_relative 'train.rb'
require_relative 'route.rb'
require_relative 'station.rb'
require_relative 'car.rb'

# frozen_string_literal: true

s1 = Station.new('Prague')
s2 = Station.new('Brno')
t1 = CargoTrain.new('111-AB')
r1 = Route.new(s1, s2)
t1.add_car(Car.new(:cargo, 100))
t1.add_car(Car.new(:cargo, 10))
t1.assign_route(r1)

puts 'Printing station:'
s1.each_train { |train| puts train.to_s }

puts 'Printing train:'
t1.each_car { |car| puts car.to_s }
