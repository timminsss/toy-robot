require_relative '../lib/toy_robot'
require 'stringio'

describe ToyRobot do
  let(:toy_robot) { ToyRobot.new }

  describe '.new' do
    it 'sets the default initial values' do

      expect(toy_robot.x).to eq(0)
      expect(toy_robot.y).to eq(0)
      expect(toy_robot.direction).to eq('NORTH')
    end

    context 'when provided specific values' do
      let(:toy_robot) { ToyRobot.new(x: 3, y: 5, direction: 'SOUTH') }

      it 'uses the given values' do
        expect(toy_robot.x).to eq(3)
        expect(toy_robot.y).to eq(5)
        expect(toy_robot.direction).to eq('SOUTH')
      end
    end

  end

  describe '#place' do
    # COME BACK TO THIS
    # returns true if successfully placed
    # placement = array
    # place valid returns true
    context 'when provided specific values in correct format' do
      let()
      it 'places the robot on the table' do
        expect do
          robot.place
        end
      end
    end
    context 'when place is in scope' do

    end
    context 'when place is correct format' do

    end

  end

  # describe '#out_of_scope?' do
  #   let(:toy_robot) { ToyRobot.new(table_length: table_length) }
  #   let(:table_length) { 5 }

  #   it 'returns true when out of scope' do
  #     expect(toy_robot.out_of_scope?(-1)).to eq(true)
  #   end

  #   it 'returns true when outwith table dimensions' do
  #     expect(toy_robot.out_of_scope?(6)).to eq(true)
  #   end
  # end

  describe '#move' do
    let(:toy_robot) { ToyRobot.new(on_table: true, direction: direction) }
    let(:direction) { nil }

    context 'when move is in scope' do
      before do
        allow(toy_robot).to receive(:out_of_scope?).and_return(false)
      end

      context 'when direction is north' do
        let(:direction) { 'NORTH' }

        it 'increases the y coordinate by 1' do
          expect do
            toy_robot.move
          end.to change(toy_robot, :y).by(1)
          expect(toy_robot.y).to eq(1)
        end
      end

      context 'when direction is south' do
        let(:direction) { 'SOUTH' }

        it 'increases the y coordinate by 1' do
          expect do
            toy_robot.move
          end.to change(toy_robot, :y).by(-1)
          expect(toy_robot.y).to eq(-1)
        end
      end

      context 'when direction is west' do
        let(:direction) { 'WEST' }

        it 'increases the y coordinate by 1' do
          expect do
            toy_robot.move
          end.to change(toy_robot, :x).by(-1)
          expect(toy_robot.x).to eq(-1)
        end
      end

      context 'when direction is east' do
        let(:direction) { 'EAST' }

        it 'increases the y coordinate by 1' do
          expect do
            toy_robot.move
          end.to change(toy_robot, :x).by(1)
          expect(toy_robot.x).to eq(1)
        end
      end
    end

    context 'when move is not in scope' do
      let(:direction) { 'NORTH' }
      before do
        allow(toy_robot).to receive(:out_of_scope?).and_return(true)
      end

      it 'does not move in any direction' do
        expect do
          toy_robot.move
        end.to change(toy_robot, :x).by(0)
        .and change(toy_robot, :y).by(0)
      end
    end

    context 'when robot is not on table' do
      let(:toy_robot) { ToyRobot.new(on_table: false, x: 3, y: 3) }

      it 'does not move in any direction' do
        toy_robot.direction = 'NORTH'
        expect do
          toy_robot.move
        end.to change(toy_robot, :x).by(0)
        .and change(toy_robot, :y).by(0)

        toy_robot.direction = 'EAST'
        expect do
          toy_robot.move
        end.to change(toy_robot, :x).by(0)
        .and change(toy_robot, :y).by(0)

        toy_robot.direction = 'SOUTH'
        expect do
          toy_robot.move
        end.to change(toy_robot, :x).by(0)
        .and change(toy_robot, :y).by(0)

        toy_robot.direction = 'WEST'
        expect do
          toy_robot.move
        end.to change(toy_robot, :x).by(0)
        .and change(toy_robot, :y).by(0)
      end
    end
  end

  # Testing the left method
  describe '#left' do
    context 'when robot is not on table' do
      it 'does not turn left' do
        expect do
          toy_robot.left
        end.to_not change(toy_robot, :direction)
      end
    end

    context 'when robot is on table' do
      let(:toy_robot) { ToyRobot.new(on_table: true, direction: direction) }
      let(:direction) { nil }

      context 'when direction is north' do
        let(:direction) { 'NORTH' }

        it 'turns left to become west' do
          expect do
            toy_robot.left
          end.to change(toy_robot, :direction).to('WEST')
        end
      end

      context 'when direction is west' do
        let(:direction) { 'WEST' }

        it 'turns left to become south' do
          expect do
            toy_robot.left
          end.to change(toy_robot, :direction).to('SOUTH')
        end
      end

      context 'when direction is south' do
        let(:direction) { 'SOUTH' }

        it 'turns left to become east' do
          expect do
            toy_robot.left
          end.to change(toy_robot, :direction).to('EAST')
        end
      end

      context 'when direction is east' do
        let(:direction) { 'EAST' }

        it 'turns left to become north' do
          expect do
            toy_robot.left
          end.to change(toy_robot, :direction).to('NORTH')
        end
      end
    end
  end

  # Testing the right method
  describe '#right' do
    context 'when robot is not on table' do
      it 'does not turn right' do
        expect do
          toy_robot.right
        end.to_not change(toy_robot, :direction)
      end
    end

    context 'when robot is on table' do
      let(:toy_robot) { ToyRobot.new(on_table: true, direction: direction) }
      let(:direction) { nil }

      context 'when direction is north' do
        let(:direction) { 'NORTH' }

        it 'turns right to become east' do
          expect do
            toy_robot.right
          end.to change(toy_robot, :direction).to('EAST')
        end
      end

      context 'when direction is west' do
        let(:direction) { 'WEST' }

        it 'turns right to become north' do
          expect do
            toy_robot.right
          end.to change(toy_robot, :direction).to('NORTH')
        end
      end

      context 'when direction is south' do
        let(:direction) { 'SOUTH' }

        it 'turns right to become west' do
          expect do
            toy_robot.right
          end.to change(toy_robot, :direction).to('WEST')
        end
      end

      context 'when direction is east' do
        let(:direction) { 'EAST' }

        it 'turns right to become south' do
          expect do
            toy_robot.right
          end.to change(toy_robot, :direction).to('SOUTH')
        end
      end
    end
  end

  describe '#report' do
    context 'when robot is not on table' do
      it 'returns nothing' do
        expect(toy_robot.report).to be_nil
      end
    end

    context 'when robot is on table' do
      let(:toy_robot) { ToyRobot.new(on_table: true, x: 1, y: 2, direction: 'NORTH') }

      it 'returns correct coordinates and direction' do
        expect(toy_robot.report).to eq('Current position on the tabletop: 1, 2, NORTH')
      end
    end
  end

  describe 'run' do
    # COME BACK TO THIS
    # before do
    #   allow(toy_robot).to receive(:place).and_call_original
    # end
    # mock putting right into the input'
    # expect(toy_robot).to receive(:right)

    # # PLACE  1 4 EAST
    # expect(toy_robot).to receive(:place).with([1,2,'EAST'])

    # it 'places the robot on table and sets the coordinates and direction' do
    #   input = StringIO.new("PLACE 1,2,NORTH\nRIGHT\nMOVE\nREPORT\nEND\n")
    #   output = StringIO.new

    #   # Temporarily redirect standard input and output to the StringIO objects
    #   $stdin = input
    #   $stdout = output

    #   allow_any_instance_of(Kernel).to receive(:puts) { |_, message| output.puts(message) }


    #   # Run the .run method
    #   ToyRobot.run

    #   # Reset standard input and output to their original values after the test
    #   $stdin = STDIN
    #   $stdout = STDOUT
    #   expect(output.string).to eq('--- TOY ROBOT GAME ---\nInput your first command (first command must be PLACE X, Y, DIRECTION)\nCurrent position on the tabletop: 1, 2, NORTH\nCurrent position on the tabletop: 2, 1, EAST\nGoodbye\n')
    # end
  end
end
