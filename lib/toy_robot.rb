# frozen_string_literal: true

require 'pry-byebug'

class ToyRobot
  attr_accessor :x, :y, :direction, :robot_on_table

  def initialize(x: 0, y: 0, direction: 'NORTH', on_table: false, table_length: 5)
    @table_length = table_length
    @x = x
    @y = y
    @direction = direction
    @robot_on_table = on_table
  end

  def place(input)
    placement = input.upcase.split(/, | |,/, 4)
    return unless place_valid?(placement)

    @x = placement[1].to_i
    @y = placement[2].to_i
    @direction = placement[3]
    @robot_on_table = true
  end

  def move
    return unless @robot_on_table

    case @direction
    when 'NORTH'
      @y += 1 unless out_of_scope?(@y + 1)
    when 'SOUTH'
      @y -= 1 unless out_of_scope?(@y - 1)
    when 'WEST'
      @x -= 1 unless out_of_scope?(@x - 1)
    when 'EAST'
      @x += 1 unless out_of_scope?(@x + 1)
    end
  end

  def left
    return unless @robot_on_table

    left_direction_change = {
      'NORTH' => 'WEST',
      'WEST' => 'SOUTH',
      'SOUTH' => 'EAST',
      'EAST' => 'NORTH'
    }

    @direction = left_direction_change[@direction]
  end

  def right
    return unless @robot_on_table

    right_direction_change = {
      'NORTH' => 'EAST',
      'EAST' => 'SOUTH',
      'SOUTH' => 'WEST',
      'WEST' => 'NORTH'
    }

    @direction = right_direction_change[@direction]
  end

  def report
    return unless @robot_on_table

    "Current position on the tabletop: #{@x}, #{@y}, #{@direction}"
  end

  private

  def out_of_scope?(position)
    position.negative? || position > @table_length - 1
  end

  def string_a_number?(string)
    Integer(string)
    true
  rescue ArgumentError, TypeError
    false
  end

  def place_valid?(placement)
    string_a_number?(placement[1]) &&
      string_a_number?(placement[2]) &&
      %w[NORTH SOUTH WEST EAST].include?(placement[3])
  end
end
