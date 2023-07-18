require_relative '../lib/app.rb'
require_relative '../lib/toy_robot.rb'

require 'stringio'

def get_command
  $stdin.gets.chomp
end


describe 'app' do
  describe '#run_commands' do
    # before do
    #   $stdin = StringIO.new("PLACE 1,1,NORTH\n")
    # end
    # after do
    #   $stdin = STDIN
    # end
    let(:toy_robot) { ToyRobot.new}
    context 'when giving the toy robot commands' do
      it 'place command runs place method' do
        # # Mocking standard input with StringIO

        $stdin = StringIO.new("PLACE 1,1,NORTH\n")

        byebug
        run_commands(toy_robot, get_command)

        $stdin = STDIN
        expect(toy_robot.report).to eq('Current position on the tabletop: 1, 1, NORTH')
      end



      # it 'places, moves, turns robot left/right & reports robot position when commands are valid' do
      #   toy_robot.place('place 0,0,north')
      #   toy_robot.move
      #   toy_robot.right
      #   toy_robot.move
      #   expect(toy_robot.report).to eq('Current position on the tabletop: 1, 1, EAST')
      # end

      # context 'when commands are not valid' do
      #   it 'does not place robot on tabletop' do
      #     toy_robot.place('0,0,north')
      #     expect(toy_robot.report).to be_nil
      #   end
      #   it 'does not move if at edge of tabletop' do
      #     toy_robot.place('4,4,north')
      #     toy_robot.move
      #     expect(toy_robot.report).to be_nil
      #   end
      # end

      # it 'does not do anything with a random command' do
      #   toy_robot.direction
      #   expect(toy_robot.report).to be_nil
      # end
    end

    # it 'stops running if command is end at the start' do
    #   toy_robot.end
    #   expect(toy_robot)
    # end
  end
end
