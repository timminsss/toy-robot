# frozen_string_literal: true

require 'pry-byebug'

class ToyRobot
  MOVE_COORD_CHANGE = {
    'NORTH' => [0, 1],
    'WEST' => [-1, 0],
    'SOUTH' => [0, -1],
    'EAST' => [1, 0]
  }.freeze

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

    movement = MOVE_COORD_CHANGE[@direction]
    new_x = @x + movement[0]
    new_y = @y + movement[1]

    return if out_of_scope?(new_x) || out_of_scope?(new_y)

    @x = new_x
    @y = new_y
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
