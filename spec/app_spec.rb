# frozen_string_literal: true

require_relative '../lib/toy_robot_app'
require_relative '../lib/toy_robot'

describe ToyRobotApp do
  let(:toy_robot_app) { ToyRobotApp.new }

  describe '#messages' do
    context 'when welcome_message called' do
      it 'welcome message displays' do
        message = "--- TOY ROBOT ---\nInput your first command (first command must be PLACE X, Y, DIRECTION)\n"
        expect do
          toy_robot_app.welcome_message
        end.to output(message).to_stdout
      end
    end

    context 'when first_command_message called' do
      it 'first command message displays' do
        message = "First command must be PLACE X, Y, DIRECTION\n"
        expect do
          toy_robot_app.first_command_message
        end.to output(message).to_stdout
      end
    end

    context 'when wrong_command_message called' do
      it 'wrong command message displays' do
        message = "Wrong input, try again. Commands are PLACE, MOVE, LEFT, RIGHT, REPORT, END\n"
        expect do
          toy_robot_app.wrong_command_message
        end.to output(message).to_stdout
      end
    end

    context 'when goodbye_message called' do
      it 'goodbye message displays' do
        message = "Goodbye - thanks for coming by.\n"
        expect do
          toy_robot_app.goodbye_message
        end.to output(message).to_stdout
      end
    end
  end

  describe '#run_commands' do
    context 'when first command is END' do
      it 'breaks out of the loop' do
        allow(toy_robot_app).to receive(:gets).and_return("END\n")
        expect(toy_robot_app).to receive(:goodbye_message).once

        # start loop with valid place command
        toy_robot_app.run_commands('END')
      end
    end

    context 'when any command is END' do
      it 'breaks out of the loop' do
        allow(toy_robot_app).to receive(:gets).and_return("END\n")
        expect(toy_robot_app).to receive(:goodbye_message).once

        toy_robot_app.run_commands('PLACE 1,2,NORTH')
      end
    end

    context 'when there is a sequence of commands' do
      it 'outputs the correct report when "REPORT" command is given' do
        # this allow stubs the input to simulate user input
        allow(toy_robot_app).to receive(:command_input).and_return(
          'PLACE 1,1,NORTH',
          'MOVE',
          'MOVE',
          'RIGHT',
          'MOVE',
          'REPORT',
          'END'
        )

        # this stubs the puts method - catches the output
        output = StringIO.new
        allow($stdout).to receive(:puts) { |*args| output.puts(*args) }
        toy_robot_app.run_toy_robot
        expect(output.string).to include('Current position on the tabletop: 2, 3, EAST')
      end
    end
  end
end
