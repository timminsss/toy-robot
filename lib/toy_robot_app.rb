# frozen_string_literal: true

require_relative 'toy_robot'
require 'pry-byebug'

class ToyRobotApp
  def initialize
    @toy_robot = ToyRobot.new
  end

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

  def command_input
    gets.chomp.upcase
  end

  def run_commands(command)
    loop do
      case command
      when /\APLACE/
        @toy_robot.place(command)
      when 'MOVE'
        @toy_robot.move
      when 'LEFT'
        @toy_robot.left
      when 'RIGHT'
        @toy_robot.right
      when 'REPORT'
        puts @toy_robot.report
      when 'END'
        goodbye_message
        break
      else
        wrong_command_message
      end
      command = command_input
    end
  end

  def run_toy_robot
    welcome_message

    command = command_input
    until @toy_robot.place(command)
      break if command == 'END'

      first_command_message
      command = command_input
    end

    run_commands(command)
  end


end

ToyRobotApp.new.run_toy_robot
