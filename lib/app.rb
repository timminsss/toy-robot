# frozen_string_literal: true

require_relative 'toy_robot'
require 'pry-byebug'

def run
  robot = ToyRobot.new

  puts '--- TOY ROBOT GAME ---'
  puts 'Input your first command (first command must be PLACE X, Y, DIRECTION)'

  # ENSURE PLACE COMMAND IS VALID
  input = gets.chomp.upcase
  until input.start_with?('PLACE')
    puts 'First command must be PLACE'
    input = gets.chomp.upcase
  end

  loop do
    case input
    when /\APLACE/
      robot.place(input)
    when 'MOVE'
      robot.move
    when 'LEFT'
      robot.left
    when 'RIGHT'
      robot.right
    when 'REPORT'
      puts robot.report
    when 'END'
      puts 'Goodbye'
      break
    else
      puts 'Wrong input, try again.'
    end
    input = gets.chomp.upcase
  end
end

run
