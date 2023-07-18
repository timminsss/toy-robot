require_relative '../lib/toy_robot'

# required to allow user input (gets.chomp)
# https://stackoverflow.com/questions/17258630/how-do-i-write-an-rspec-test-for-a-ruby-method-that-contains-gets-chomp
require 'stringio'

def get_command
  $stdin.gets.chomp
end

def reset_std_input
  $stdin = STDIN
end

describe ToyRobot do
  let(:toy_robot) { ToyRobot.new }

  describe '.new' do
    it 'sets the default initial values' do

      expect(toy_robot.x).to eq(0)
      expect(toy_robot.y).to eq(0)
      expect(toy_robot.direction).to eq('NORTH')
    end

    context 'when provided specific values' do
      let(:toy_robot) { ToyRobot.new(x: 3, y: 4, direction: 'SOUTH') }

      it 'uses the specfic values' do
        expect(toy_robot.x).to eq(3)
        expect(toy_robot.y).to eq(4)
        expect(toy_robot.direction).to eq('SOUTH')
      end
    end
  end

  describe '#place' do
    context 'when provided place command is valid' do
      before do
        $stdin = StringIO.new("PLACE 1,1,NORTH\n")
      end

      it 'turns place command into array' do
        # .send allows to run private method
        array = toy_robot.send(:place_command_array, get_command)
        expect(array).to be_an(Array)
        expect(array.length).to eq(4)
      end

      it 'validates place command' do
        array = toy_robot.send(:place_command_array, get_command)
        place_valid = toy_robot.send(:place_valid?, array)
        expect(place_valid).to eq(true)
      end

      it 'places the robot on the table' do
        toy_robot.place(get_command)
        expect(toy_robot.robot_on_table).to eq(true)
      end

      after do
        reset_std_input
      end
    end

    context 'when provided place command is invalid' do
      context 'when place command values are in wrong order' do
        before do
          $stdin = StringIO.new("PLACE NORTH,1,1\n")
        end

        it 'does not place robot on table' do
          expect(toy_robot.place(get_command)).to be_falsey
        end

        after do
          reset_std_input
        end
      end

      context 'when place command values are not valid' do
        before do
          $stdin = StringIO.new("PLACE 1\n")
        end

        it 'does not place robot on table' do
          expect(toy_robot.place(get_command)).to be_falsey
        end

        after do
          reset_std_input
        end
      end
    end

    context 'when provided place command has values out of scope' do
      it 'does not place robot on the table' do
        expect(toy_robot.send(:out_of_scope?, 6)).to be_truthy
      end
    end

    context 'when robot is placed on table' do
      before do
        $stdin = StringIO.new("PLACE 1,1,NORTH\n")
      end

      it 'method returns true (needed for app.rb to run)' do
        expect(toy_robot.place(get_command)).to be_truthy
      end

      after do
        reset_std_input
      end
    end
  end

  describe '#move' do
    let(:toy_robot) { ToyRobot.new(on_table: true, direction: direction) }
    let(:direction) { nil }

    context 'when move is in scope' do
      before do
        #  receive stubs/mocks out of scope method to false without running method
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

        it 'decreases the y coordinate by 1' do
          expect do
            toy_robot.move
          end.to change(toy_robot, :y).by(-1)
          expect(toy_robot.y).to eq(-1)
        end
      end

      context 'when direction is west' do
        let(:direction) { 'WEST' }

        it 'decreases the x coordinate by 1' do
          expect do
            toy_robot.move
          end.to change(toy_robot, :x).by(-1)
          expect(toy_robot.x).to eq(-1)
        end
      end

      context 'when direction is east' do
        let(:direction) { 'EAST' }

        it 'increases the x coordinate by 1' do
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
        end.to_not change(toy_robot, :x)
        expect do
          toy_robot.move
        end.to_not change(toy_robot, :y)
      end
    end

    context 'when robot is not on table' do
      let(:toy_robot) { ToyRobot.new(on_table: false, x: 3, y: 3) }

      it 'does not move in any direction' do
        directions = %w[NORTH SOUTH WEST EAST]
        directions.each do |direction|
          toy_robot.direction = direction
          expect do
            toy_robot.move
          end.to_not change(toy_robot, :x)
          expect do
            toy_robot.move
          end.to_not change(toy_robot, :y)
        end
      end
    end
  end

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
end
