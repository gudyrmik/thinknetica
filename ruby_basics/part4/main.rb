require_relative 'train.rb'
require_relative 'route.rb'
require_relative 'station.rb'
require_relative 'car.rb'
require_relative 'rail_road.rb'

rail_road = RailRoad.new

COMMAND_PROMPT = '>_: '

operation = -1
while operation != 0 do
  puts 'Введите номер операции:'
  puts ' [1] для управления Ж/Д станциями'
  puts ' [2] для управления поездами'
  puts ' [3] для управления маршрутами'
  puts ' [4] для получения информации о всех Ж/Д объектах'
  puts ' [0] для выхода из программы'
  print COMMAND_PROMPT

  operation = gets.chomp.to_i
  suboperation = -1

  case operation
  when 1  # меню операций с станциями
    while suboperation != 0 do
      puts 'Панель управления Ж/Д станциями. Введите номер подоперации:'
      puts ' [1] для создания новой Ж/Д станции'
      puts ' [2] для удалений Ж/Д станции'
      puts ' [3] для получения списка всех Ж/Д станций'
      puts ' [0] для возвращения к главной панели'
      print COMMAND_PROMPT

      suboperation = gets.chomp.to_i

      case suboperation
      when 1
        print 'Введите название станции: '
        rail_road.add_station(gets.chomp)
      when 2
        rail_road.list_stations
        print 'Выберите номер станции для удаления: '
        rail_road.remove_station(gets.chomp.to_i)
      when 3
        rail_road.list_stations
      end
    end
  when 2  # меню операций с поездами
    while suboperation != 0 do
      puts 'Панель управления поездами. Введите номер подоперации:'
      puts ' [1] для создания нового поезда'
      puts ' [2] для удаления поезда'
      puts ' [3] для добавления вагона к поезду'
      puts ' [4] для отцепления вагона от поезда'
      puts ' [5] для назначения поезду маршрута'
      puts ' [6] для движения вперед по маршруту'
      puts ' [7] для движения назад по маршруту'
      puts ' [8] для получения списка всех поездов'
      puts ' [0] для возвращения к главной панели'
      print COMMAND_PROMPT

      suboperation = gets.chomp.to_i

      case suboperation
      when 1  # создание нового поезда
        print 'Введите серийный номер поезда: '
        serial_number = gets.chomp
        puts 'Выберите тип поезда:'
        puts ' [1] пассажирский поезд'
        puts ' [2] грузовой поезд'
        print command_prompt
        case gets.chomp.to_i
        when 1  # выбор типа нового поезда - пассажирский
          rail_road.add_passenger_train(serial_number)
        when 2  # выбор типа нового поезда - грузовой
          rail_road.add_cargo_train(serial_number)
        end
      when 2  # удаление поезда
        rail_road.list_trains
        print 'Выберете номер поезда для удаления: '
        rail_road.remove_train(gets.chomp.to_i)
      when 3  # добавление вагона к поезду
        rail_road.list_trains
        print 'Выберете номер поезда, к которому добавить вагон: '
        rail_road.add_car_to_train(gets.chomp.to_i)
      when 4  # отцепление вагонов от поезда
        rail_road.list_trains
        print 'Выберете номер поезда, от которого отцепить вагон: '
        rail_road.remove_car_from_train(gets.chomp.to_i)
      when 5  # назначение маршрута поезду
        puts 'Поезда:'
        rail_road.list_trains
        puts 'Маршруты:'
        rail_road.list_routes
        print 'Выберете номер поезда: '
        train_number = gets.chomp.to_i
        print 'Выберете номер маршрута: '
        route_number = gets.chomp.to_i
        rail_road.assign_train_on_route(train_number, route_number)
      when 6  # движение вперед по маршруту
        rail_road.list_trains
        print 'Выберете номер поезда: '
        rail_road.train_move_forward(gets.chomp.to_i)
      when 7  # движение назад по маршруту
        rail_road.list_trains
        print 'Выберете номер поезда: '
        rail_road.train_move_backward(gets.chomp.to_i)
      when 8  # вывод списка поездов
        rail_road.list_trains
      end
    end
  when 3  # меню операций с маршрутами
    while suboperation != 0 do
      puts 'Панель управления маршрутами. Введите номер подоперации:'
      puts ' [1] для создания нового маршрута'
      puts ' [2] для удаления маршрута'
      puts ' [3] для добавления промежуточной станции к маршруту'
      puts ' [4] для удаления промежуточной станции из марщрута'
      puts ' [5] для получения списка всех маршрутов'
      puts ' [0] для возвращения к главной панели'
      print COMMAND_PROMPT

      suboperation = gets.chomp.to_i

      case suboperation
      when 1  # создание нового маршрута
        rail_road.list_stations
        print 'Введите номер станции отправления: '
        source_number = gets.chomp.to_i
        print 'Введите номер станции назначения: '
        destination_number = gets.chomp.to_i
        rail_road.add_route(source_number, destination_number)
      when 2  # удаление маршрута
        rail_road.list_routes
        print 'Выберете номер маршрута для удаления: '
        rail_road.remove_route(gets.chomp.to_i)
      when 3  # добавление станции к маршруту
        puts 'Станции:'
        rail_road.list_stations
        puts 'Маршруты:'
        rail_road.list_routes
        print 'Выберете номер маршрута: '
        route_number = gets.chomp.to_i
        print 'Выберете номер станции: '
        station_number = gets.chomp.to_i
        rail_road.add_station_to_route(station_number, route_number)
      when 4  # удаление станции из маршрута
        puts 'Станции:'
        rail_road.list_stations
        puts 'Маршруты:'
        rail_road.list_routes
        print 'Выберете номер маршрута: '
        route_number = gets.chomp.to_i
        print 'Выберете номер станции: '
        station_number = gets.chomp.to_i
        rail_road.remove_station_from_route(station_number, route_number)
      when 5  # получение списка маршрутов
        rail_road.list_routes
      end
    end
  when 4  # информация по всей Ж/Д
    puts 'Станции:'
    rail_road.list_stations
    puts 'Поезда:'
    rail_road.list_trains
    puts 'Маршруты:'
    rail_road.list_routes
  end
end