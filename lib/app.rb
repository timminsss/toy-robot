# frozen_string_literal: true

require_relative 'toy_robot'
require 'pry-byebug'

def welcome_message
  puts '--- TOY ROBOT GAME ---'
  puts 'Input your first command (first command must be PLACE X, Y, DIRECTION)'
end

def first_input_message
  puts 'First command must be PLACE X, Y, DIRECTION'
end

def wrong_input_message
  puts 'Wrong input, try again.'
end

def goodbye_message
  puts 'Goodbye - thanks for coming by.'
end

def run
  robot = ToyRobot.new

  welcome_message

  input = gets.chomp.upcase
  until input.start_with?('PLACE')
  # until input.start_with?('PLACE')
    first_input_message
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
      goodbye_message
      break
    else
      wrong_input_message
    end
    input = gets.chomp.upcase
  end
end

run
