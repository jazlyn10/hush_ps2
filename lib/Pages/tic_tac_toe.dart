import 'package:flutter/material.dart';


class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  //adding the necessary variables
  String lastValue = "X";
  bool gameOver = false;
  int turn = 0; // to check the draw
  String result = "";
  List<int> scoreboard = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ]; //the score are for the different combination of the game [Row1,2,3, Col1,2,3, Diagonal1,2];
  //let's declare a new Game components

  Game game = Game();

  //let's initi the GameBoard
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game.board = Game.initGameBoard();
    print(game.board);
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
        backgroundColor: MainColor.primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "It's ${lastValue} turn".toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 58,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            //now we will make the game board
            //but first we will create a Game class that will contains all the data and method that we will need
            Container(
              width: boardWidth,
              height: boardWidth,
              child: GridView.count(
                crossAxisCount: Game.boardlenth ~/
                    3, // the ~/ operator allows you to evide to integer and return an Int as a result
                padding: EdgeInsets.all(16.0),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                children: List.generate(Game.boardlenth, (index) {
                  return InkWell(
                    onTap: gameOver
                        ? null
                        : () {
                      //when we click we need to add the new value to the board and refrech the screen
                      //we need also to toggle the player
                      //now we need to apply the click only if the field is empty
                      //now let's create a button to repeat the game

                      if (game.board![index] == "") {
                        setState(() {
                          game.board![index] = lastValue;
                          turn++;
                          gameOver = game.winnerCheck(
                              lastValue, index, scoreboard, 3);

                          if (gameOver) {
                            result = "$lastValue is the Winner";
                          } else if (!gameOver && turn == 9) {
                            result = "It's a Draw!";
                            gameOver = true;
                          }
                          if (lastValue == "X")
                            lastValue = "O";
                          else
                            lastValue = "X";
                        });
                      }
                    },
                    child: Container(
                      width: Game.blocSize,
                      height: Game.blocSize,
                      decoration: BoxDecoration(
                        color: MainColor.secondaryColor,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Center(
                        child: Text(
                          game.board![index],
                          style: TextStyle(
                            color: game.board![index] == "X"
                                ? Colors.blue
                                : Colors.pink,
                            fontSize: 64.0,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Text(
              result,
              style: TextStyle(color: Colors.white, fontSize: 54.0),
            ),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  //erase the board
                  game.board = Game.initGameBoard();
                  lastValue = "X";
                  gameOver = false;
                  turn = 0;
                  result = "";
                  scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
                });
              },
              label: Text("Play Again"),
              icon: Icon(Icons.replay),
            ),
          ],
        ));
    //the first step is organise our project folder structure
  }
}


class Player {
  static const x = "X";
  static const o = "O";
  static const empty = "";
}

class Game {
  static final boardlenth = 9; // we will creare a board of 3*3 blocks;
  static final blocSize = 100.0;

  //Creating the empty board
  List<String>? board;

  static List<String>? initGameBoard() =>
      List.generate(boardlenth, (index) => Player.empty);

  //now we need to build the winner check algorithm
  //for this we need first to declare a scoreboard in our main file
  bool winnerCheck(
      String player, int index, List<int> scoreboard, int gridSize) {
    //first let's declare the row   and col
    int row = index ~/ 3;
    int col = index % 3;
    int score = player == "X" ? 1 : -1;

    scoreboard[row] += score;
    scoreboard[gridSize + col] += score;
    if (row == col) scoreboard[2 * gridSize] += score;
    if (gridSize - 1 - col == row) scoreboard[2 * gridSize + 1] += score;

    //checking if we have 3 or -3 in the score board
    if (scoreboard.contains(3) || scoreboard.contains(-3)) {
      return true;
    }
    ;

    //by default it will return false
    return false;
  }
}


//now let's add the color that we will need to project


class MainColor {
  static Color primaryColor = Color(0xFFff4b4b);
  static Color secondaryColor = Color(0xFFffca27);
  static Color accentColor = Color(0xFF4169e8);
}
