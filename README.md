# EE2026 Final Project

## Group Information:
- **Group ID:** S1_02
- **Group Theme:** Improved Gomoku (Five in a row)

## Description:
The aim of our project is to develop an enhanced version of the classic Gomoku (Five in a Row) game, leveraging the capabilities of the Basys-3 board. Our implementation will blend traditional gameplay with modern customization options to provide users with an engaging gaming experience. We are integrating both hardware and software components to maximize user interaction and satisfaction.

## Features and Implementation Details:

### A:
- **User Interaction Integration:**
  - Incorporating keyboard and USB communication for user input.
  - Displaying user names and game information on the OLED screen.
- **Gameplay Enhancement:**
  - Introducing AI assistance for strategic move suggestions.
  - Offering two modes: player vs player and player vs AI.

### B:
- **Graphical Interface Design:**
  - Designing the game board layout and pieces representation.
  - Implementing animations for various game stages.
  - Highlighting the opponent's last move visually.
  - Implementing mouse positioning for piece placement.

### C:
- **Game Mechanics and Timing:**
  - Implementing Gomoku rules and win/loss conditions.
  - Setting timers for turns and overall game duration.
  - Providing functionalities for quitting, restarting, and replaying.
- **UART Communication:**
  - Establishing communication between boards for keyboard and mouse input.

### D:
- **Enhancement and Optimization:**
  - Developing a random number generator for deciding the first move.
  - Implementing pattern detection for strategic gameplay.
  - Designing a scoring system to evaluate board positions.
  - Determining the best move based on calculated scores.

## Setup Instructions:
- **Hardware:** Basys-3 board.
- **Software:** Appropriate development environment for FPGA programming.
- **Dependencies:** Ensure necessary libraries and drivers are installed.
- **Execution:** Compile and upload the provided code onto the Basys-3 board.

## Usage:
1. Power on the Basys-3 board.
2. Follow on-screen instructions to start a game.
3. Use keyboard and mouse for interaction.
4. Enjoy playing Gomoku with enhanced features!
