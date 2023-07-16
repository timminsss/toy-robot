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
    placement = input.split(/, | |,/, 4)
    puts placement
    return unless placement[1] && placement[2] && placement[3]

    @x = placement[1]
    @y = placement[2]
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

    case @direction
    when 'NORTH'
      @direction = 'WEST'
    when 'SOUTH'
      @direction = 'EAST'
    when 'WEST'
      @direction = 'SOUTH'
    when 'EAST'
      @direction = 'NORTH'
    end
  end

  def right
    return unless @robot_on_table

    case @direction
    when 'NORTH'
      @direction = 'EAST'
    when 'SOUTH'
      @direction = 'WEST'
    when 'WEST'
      @direction = 'NORTH'
    when 'EAST'
      @direction = 'SOUTH'
    end
  end

  def report
    return unless @robot_on_table

    "Current position on the tabletop: #{@x}, #{@y}, #{@direction}"
  end

  def self.run
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

  private

  def out_of_scope?(position)
    position.negative? || position > @table_length - 1
  end
end
