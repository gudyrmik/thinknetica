class RailRoadCLI

  def main_menu_cli
    loop do
      puts 'Введите номер операции:'
      puts ' [1] для управления Ж/Д станциями'
      puts ' [2] для управления поездами'
      puts ' [3] для управления маршрутами'
      puts ' [4] для получения информации о всех Ж/Д объектах'
      puts ' [0] для выхода из программы'
      print COMMAND_PROMPT
      input = gets.chomp.to_i

      case input
      when 1
        stations_menu_cli
      when 2
        trains_menu_cli
      when 3
        routes_menu_cli
      when 4
        info_menu_cli
      when 0
        break
      end
    end
  end

  def print_stations
    puts @rail_road.stations_to_s
  end

  def print_trains
    puts @rail_road.trains_to_s
  end

  def print_routes
    puts @rail_road.routes_to_s
  end

  def initialize
    @rail_road = RailRoad.new
  end

  private

  COMMAND_PROMPT = '>_: '

  # методы подменюшки в паблике не нужны
  # не нужны и принт-методы, но их там оставить как-то выгляждит логичнее
  def stations_menu_cli
    loop do
      puts 'Панель управления Ж/Д станциями. Введите номер подоперации:'
      puts ' [1] для создания новой Ж/Д станции'
      puts ' [2] для удалений Ж/Д станции'
      puts ' [3] для получения списка всех Ж/Д станций'
      puts ' [0] для возвращения к главной панели'
      print COMMAND_PROMPT
      input = gets.chomp.to_i

      case input
      when 1
        create_station_cli
      when 2
        delete_station_cli
      when 3
        print_stations_cli
      when 0
        break
      end
    end
  end

  def create_station_cli
    print 'Введите название станции: '
    @rail_road.add_station(gets.chomp)
  end

  def delete_station_cli
    print_stations
    print 'Выберите номер станции для удаления: '
    @rail_road.remove_station(gets.chomp.to_i)
  end

  def print_stations_cli
    print_stations
  end

  def trains_menu_cli
    loop do
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

      input = gets.chomp.to_i

      case input
      when 1  # создание нового поезда
        create_train_cli
      when 2  # удаление поезда
        delete_train_cli
      when 3  # добавление вагона к поезду
        add_car_cli
      when 4  # отцепление вагонов от поезда
        remove_car_cli
      when 5  # назначение маршрута поезду
        assign_route_cli
      when 6  # движение вперед по маршруту
        move_forward_cli
      when 7  # движение назад по маршруту
        mode_backward_cli
      when 8  # вывод списка поездов
        print_trains_cli
      when 0
        break
      end
    end
  end

  def create_train_cli
    print 'Введите серийный номер поезда: '
    serial_number = gets.chomp
    puts 'Выберите тип поезда:'
    puts ' [1] пассажирский поезд'
    puts ' [2] грузовой поезд'
    print COMMAND_PROMPT
    case gets.chomp.to_i
    when 1  # выбор типа нового поезда - пассажирский
      @rail_road.add_passenger_train(serial_number)
    when 2  # выбор типа нового поезда - грузовой
      @rail_road.add_cargo_train(serial_number)
    end
  end

  def delete_train_cli
    print_trains
    print 'Выберете номер поезда для удаления: '
    @rail_road.remove_train(gets.chomp.to_i)
  end

  def add_car_cli
    print_trains
    print 'Выберете номер поезда, к которому добавить вагон: '
    @rail_road.add_car_to_train(gets.chomp.to_i)
  end

  def remove_car_cli
    print_trains
    print 'Выберете номер поезда, от которого отцепить вагон: '
    @rail_road.remove_car_from_train(gets.chomp.to_i)
  end

  def assign_route_cli
    puts 'Поезда:'
    print_trains
    puts 'Маршруты:'
    print_routes
    print 'Выберете номер поезда: '
    train_number = gets.chomp.to_i
    print 'Выберете номер маршрута: '
    route_number = gets.chomp.to_i
    @rail_road.assign_train_on_route(train_number, route_number)
  end

  def move_forward_cli
    @rail_road.print_trains
    print 'Выберете номер поезда: '
    @rail_road.train_move_forward(gets.chomp.to_i)
  end

  def mode_backward_cli
    print_trains
    print 'Выберете номер поезда: '
    @rail_road.train_move_backward(gets.chomp.to_i)
  end

  def print_trains_cli
    print_trains
  end

  def routes_menu_cli
    loop do
      puts 'Панель управления маршрутами. Введите номер подоперации:'
      puts ' [1] для создания нового маршрута'
      puts ' [2] для удаления маршрута'
      puts ' [3] для добавления промежуточной станции к маршруту'
      puts ' [4] для удаления промежуточной станции из марщрута'
      puts ' [5] для получения списка всех маршрутов'
      puts ' [0] для возвращения к главной панели'
      print COMMAND_PROMPT
      input = gets.chomp.to_i

      case input
      when 1  # создание нового маршрута
        create_route_cli
      when 2  # удаление маршрута
        delete_route_cli
      when 3  # добавление станции к маршруту
        add_station_cli
      when 4  # удаление станции из маршрута
        remove_station_cli
      when 5  # получение списка маршрутов
        print_routes_cli
      when 0
        break
      end
    end
  end

  def create_route_cli
    print_stations
    print 'Введите номер станции отправления: '
    source_number = gets.chomp.to_i
    print 'Введите номер станции назначения: '
    destination_number = gets.chomp.to_i
    @rail_road.add_route(source_number, destination_number)
  end

  def delete_route_cli
    print_routes
    print 'Выберете номер маршрута для удаления: '
    @rail_road.remove_route(gets.chomp.to_i)
  end

  def add_station_cli
    puts 'Станции:'
    print_stations
    puts 'Маршруты:'
    print_routes
    print 'Выберете номер маршрута: '
    route_number = gets.chomp.to_i
    print 'Выберете номер станции: '
    station_number = gets.chomp.to_i
    @rail_road.add_station_to_route(station_number, route_number)
  end

  def remove_station_cli
    puts 'Станции:'
    print_stations
    puts 'Маршруты:'
    print_routes
    print 'Выберете номер маршрута: '
    route_number = gets.chomp.to_i
    print 'Выберете номер станции: '
    station_number = gets.chomp.to_i
    @rail_road.remove_station_from_route(station_number, route_number)
  end

  def print_routes_cli
    print_routes
  end

  def info_menu_cli
    puts 'Станции:'
    print_stations
    puts 'Поезда:'
    print_trains
    puts 'Маршруты:'
    print_routes
  end
end