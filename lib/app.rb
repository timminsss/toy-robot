# frozen_string_literal: true

require_relative 'toy_robot'
require 'pry-byebug'

def welcome_message
  puts '--- TOY ROBOT ---'
  puts 'Input your first command (first command must be PLACE X, Y, DIRECTION)'
end

def first_command_message
  puts 'First command must be PLACE X, Y, DIRECTION'
end

def wrong_command_message
  puts 'Wrong input, try again. Commands are PLACE, MOVE, LEFT, RIGHT, REPORT, END'
end

def goodbye_message
  puts 'Goodbye - thanks for coming by.'
end

def run_commands(robot, command)
  loop do
    case command
    when /\APLACE/
      robot.place(command)
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
      wrong_command_message
    end
    command = gets.chomp.upcase
  end
end

def run_toy_robot
  robot = ToyRobot.new

  welcome_message

  command = gets.chomp.upcase
  until robot.place(command)
    first_command_message
    command = gets.chomp.upcase
    break if command == 'END'
  end

  run_commands(robot, command)
end

run_toy_robot
