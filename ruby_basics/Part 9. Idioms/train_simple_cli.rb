# frozen_string_literal: true

require_relative 'train.rb'

# Simple command line interface for trains
class TrainSimpleCLI
  def self.run
    loop do
      puts 'Введите номер поезда:'
      number = gets.chomp
      puts 'Введите тип поезда:'
      type = gets.chomp
      Train.new(number, type)
    rescue StandardError => e
      puts e.message
    end
  end
end
