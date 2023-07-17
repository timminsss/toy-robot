# TOY ROBOT CHALLENGE

This Ruby command line application is a simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units.

## Introduction

- The application is a simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units.
- There are no other obstructions on the table surface.
- The robot is free to roam around the surface of the table, but must be prevented from falling to destruction.
- Any movement that would result in the robot falling from the table must be prevented, however further valid movement commands must still be allowed.
- The robot can read the commands
  - PLACE X,Y,F
  - MOVE
  - LEFT
  - RIGHT
  - REPORT

## Environment

This application requires Ruby 3.1.2 or later. Check which version you have:
```
$ ruby -v
```

## Installation

Clone the repository and set up on your local machine.
```
$ git clone https://github.com/timminsss/toy-robot.git
$ cd toy-robot
$ bundle install
```

Now you're ready to go - run the project:
```
ruby lib/app.rb
```

## Testing

Start testing using rspec:
```
rspec
```

## Usage

```
ruby lib/app.rb
```
This will start the app, and give a prompt:
```
--- TOY ROBOT ---
Input your first command (first command must be PLACE X, Y, DIRECTION)
```
Commands are as follows:

- PLACE X,Y,DIRECTION
  - Puts the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST.
- MOVE
  - Moves the toy robot one unit forward in the direction it is currently facing.
- LEFT
  - Rotates the robot 90 degrees in the left direction without changing the position of the robot.
- RIGHT
  - Rotates the robot 90 degrees in the right direction without changing the position of the robot.
- REPORT
  - Announces the X,Y and direction of the robot.
- END
  - Ends the application.

Other things to note:

- The origin (0,0) can be considered to be the SOUTH WEST most corner.
- The first valid command to the robot is a PLACE command, after that, any sequence of commands may be issued, in any order, including another PLACE command. The application will discard all commands in the sequence until a valid PLACE command has been executed.
- A robot that is not on the table will ignore the MOVE, LEFT, RIGHT and REPORT commands.
- Commands moving/placing the robot out of bounds will be ignored.
- The REPORT command can be used many times throughout the session.

Example usage:
```
> PLACE 0,0,NORTH
> MOVE
> REPORT
Current position on the tabletop: 0,1,NORTH
```
```
> PLACE 0,0,NORTH
> LEFT
> REPORT
Current position on the tabletop: 0,0,WEST
```
```
> PLACE 1,2,EAST
> MOVE
> MOVE
> LEFT
> MOVE
> REPORT
Current position on the tabletop: 3,3,NORTH
```
