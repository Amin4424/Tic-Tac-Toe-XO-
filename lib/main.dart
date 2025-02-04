import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'dart:math';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tic Tac Toe',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(173, 20, 0, 0),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              alignment: Alignment.center,
              height: 200,
              child: Image.asset(
                'assets/images/OSK.jpg',
                width: 1000,
              ),
            ),
            const Divider(
              color: Color.fromARGB(255, 239, 237, 237),
              thickness: 2,
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                _VsBotPageState.gameOver_against_bot = false;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VsBotPage()),
                );
              },
              child: const Text(
                'Player vs Bot',
                style: TextStyle(fontSize: 40.0, color: Colors.blueGrey),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {
                _VsHumanPageState.gameOver = false;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VsHumanPage()),
                );
              },
              child: const Text(
                'Player vs Player',
                style: TextStyle(fontSize: 40.0, color: Colors.blueGrey),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Opacity(
              opacity: 0.8,
              child: Divider(
                color: Colors.white,
                thickness: 2,
              ),
            ),
            IconButton(
              icon: Icon(Icons.error_outline),
              color: Colors.blueGrey,
              iconSize: 40.0,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Details'),
                      content: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'Game developed by Amin4424.\n\nSource available on ',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: 'github.com/Amin4424',
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  const url = 'https://github.com/Amin4424';
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class VsHumanPage extends StatefulWidget {
  @override
  State<VsHumanPage> createState() => _VsHumanPageState();
}

class _VsHumanPageState extends State<VsHumanPage> {
  List<bool> boolList = List<bool>.filled(18, false);
  Game game = Game();
  static bool gameOver = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Against Human',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        backgroundColor: Colors.amber,
      ),
      body: Container(
          color: Colors.black,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(Icons.circle_outlined,
                        color: Color.fromARGB(219, 5, 219, 80), size: 24.0),
                    SizedBox(width: 10),
                    Text('Player 1',
                        style: TextStyle(
                            color: Color.fromARGB(219, 5, 219, 80),
                            fontSize: 24)),
                    SizedBox(
                      width: 30,
                    ),
                    Icon(Icons.clear,
                        color: Color.fromARGB(235, 156, 224, 135), size: 24.0),
                    SizedBox(width: 10),
                    Text('Player 2',
                        style: TextStyle(
                            color: Color.fromARGB(235, 156, 224, 135),
                            fontSize: 24)),
                  ],
                ),
                const SizedBox(height: 110),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (gameOver) return;
                            setState(() {
                              int icon_to_show = game.movePlayer([0, 0]);
                              if (icon_to_show == 1) {
                                boolList[0] = true;
                              }
                              if (icon_to_show == 2) {
                                boolList[1] = true;
                              }
                            });
                            game.checkWin(context);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all<Color>(Colors.blue),
                            minimumSize: WidgetStateProperty.all<Size>(
                                const Size(100, 100)),
                          ),
                          child: boolList[0]
                              ? const Icon(
                                  Icons.circle_outlined,
                                  size: 50,
                                )
                              : boolList[1]
                                  ? const Icon(
                                      Icons.clear,
                                      size: 50,
                                    )
                                  : const Text('         '),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (gameOver) return;
                            setState(() {
                              int icon_to_show = game.movePlayer([1, 0]);
                              if (icon_to_show == 1) {
                                boolList[2] = true;
                              }
                              if (icon_to_show == 2) {
                                boolList[3] = true;
                              }
                            });
                            game.checkWin(context);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all<Color>(Colors.blue),
                            minimumSize: WidgetStateProperty.all<Size>(
                                const Size(100, 100)),
                          ),
                          child: boolList[2]
                              ? const Icon(
                                  Icons.circle_outlined,
                                  size: 50,
                                )
                              : boolList[3]
                                  ? const Icon(
                                      Icons.clear,
                                      size: 50,
                                    )
                                  : const Text('         '),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (gameOver) return;
                            setState(() {
                              int icon_to_show = game.movePlayer([2, 0]);
                              if (icon_to_show == 1) {
                                boolList[4] = true;
                              }
                              if (icon_to_show == 2) {
                                boolList[5] = true;
                              }
                            });
                            game.checkWin(context);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all<Color>(Colors.blue),
                            minimumSize: WidgetStateProperty.all<Size>(
                                const Size(100, 100)),
                          ),
                          child: boolList[4]
                              ? const Icon(
                                  Icons.circle_outlined,
                                  size: 50,
                                )
                              : boolList[5]
                                  ? const Icon(
                                      Icons.clear,
                                      size: 50,
                                    )
                                  : const Text('         '),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (gameOver) return;
                            setState(() {
                              int icon_to_show = game.movePlayer([0, 1]);
                              if (icon_to_show == 1) {
                                boolList[6] = true;
                              }
                              if (icon_to_show == 2) {
                                boolList[7] = true;
                              }
                            });
                            game.checkWin(context);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all<Color>(Colors.blue),
                            minimumSize: WidgetStateProperty.all<Size>(
                                const Size(100, 100)),
                          ),
                          child: boolList[6]
                              ? const Icon(
                                  Icons.circle_outlined,
                                  size: 50,
                                )
                              : boolList[7]
                                  ? const Icon(
                                      Icons.clear,
                                      size: 50,
                                    )
                                  : const Text('         '),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (gameOver) return;
                            setState(() {
                              int icon_to_show = game.movePlayer([1, 1]);
                              if (icon_to_show == 1) {
                                boolList[8] = true;
                              }
                              if (icon_to_show == 2) {
                                boolList[9] = true;
                              }
                            });
                            game.checkWin(context);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all<Color>(Colors.blue),
                            minimumSize: WidgetStateProperty.all<Size>(
                                const Size(100, 100)),
                          ),
                          child: boolList[8]
                              ? const Icon(
                                  Icons.circle_outlined,
                                  size: 50,
                                )
                              : boolList[9]
                                  ? const Icon(
                                      Icons.clear,
                                      size: 50,
                                    )
                                  : const Text('         '),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (gameOver) return;
                            setState(() {
                              int icon_to_show = game.movePlayer([2, 1]);
                              if (icon_to_show == 1) {
                                boolList[10] = true;
                              }
                              if (icon_to_show == 2) {
                                boolList[11] = true;
                              }
                            });
                            game.checkWin(context);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all<Color>(Colors.blue),
                            minimumSize: WidgetStateProperty.all<Size>(
                                const Size(100, 100)),
                          ),
                          child: boolList[10]
                              ? const Icon(
                                  Icons.circle_outlined,
                                  size: 50,
                                )
                              : boolList[11]
                                  ? const Icon(
                                      Icons.clear,
                                      size: 50,
                                    )
                                  : const Text('         '),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (gameOver) return;
                            setState(() {
                              int icon_to_show = game.movePlayer([0, 2]);
                              if (icon_to_show == 1) {
                                boolList[12] = true;
                              }
                              if (icon_to_show == 2) {
                                boolList[13] = true;
                              }
                            });
                            game.checkWin(context);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all<Color>(Colors.blue),
                            minimumSize: WidgetStateProperty.all<Size>(
                                const Size(100, 100)),
                          ),
                          child: boolList[12]
                              ? const Icon(
                                  Icons.circle_outlined,
                                  size: 50,
                                )
                              : boolList[13]
                                  ? const Icon(
                                      Icons.clear,
                                      size: 50,
                                    )
                                  : const Text('         '),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (gameOver) return;
                            setState(() {
                              int icon_to_show = game.movePlayer([1, 2]);
                              if (icon_to_show == 1) {
                                boolList[14] = true;
                              }
                              if (icon_to_show == 2) {
                                boolList[15] = true;
                              }
                            });
                            game.checkWin(context);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all<Color>(Colors.blue),
                            minimumSize: WidgetStateProperty.all<Size>(
                                const Size(100, 100)),
                          ),
                          child: boolList[14]
                              ? const Icon(
                                  Icons.circle_outlined,
                                  size: 50,
                                )
                              : boolList[15]
                                  ? const Icon(
                                      Icons.clear,
                                      size: 50,
                                    )
                                  : const Text('         '),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (gameOver) return;
                            setState(() {
                              int icon_to_show = game.movePlayer([2, 2]);
                              if (icon_to_show == 1) {
                                boolList[16] = true;
                              }
                              if (icon_to_show == 2) {
                                boolList[17] = true;
                              }
                            });
                            game.checkWin(context);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all<Color>(Colors.blue),
                            minimumSize: WidgetStateProperty.all<Size>(
                                const Size(100, 100)),
                          ),
                          child: boolList[16]
                              ? const Icon(
                                  Icons.circle_outlined,
                                  size: 50,
                                )
                              : boolList[17]
                                  ? const Icon(
                                      Icons.clear,
                                      size: 50,
                                    )
                                  : const Text('         '),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

class VsBotPage extends StatefulWidget {
  @override
  State<VsBotPage> createState() => _VsBotPageState();
}

class _VsBotPageState extends State<VsBotPage> {
  List<int> buttonStates = List.filled(9, 0);
  static bool gameOver_against_bot = false;
  int choose_turn = 0;
  @override
  void initState() {
    super.initState();
    choose_turn = chooseTurn();
  }

  bool checkWin() {
    bool is_over = false;
    int winner = 0;
    if (buttonStates[0] == buttonStates[3] &&
        buttonStates[0] == buttonStates[6]) {
      is_over = true;
      winner = buttonStates[0];
    }
    if (buttonStates[1] == buttonStates[4] &&
        buttonStates[1] == buttonStates[7]) {
      is_over = true;
      winner = buttonStates[1];
    }
    if (buttonStates[2] == buttonStates[5] &&
        buttonStates[2] == buttonStates[8]) {
      is_over = true;
      winner = buttonStates[2];
    }
    if (buttonStates[0] == buttonStates[1] &&
        buttonStates[0] == buttonStates[2]) {
      is_over = true;
      winner = buttonStates[0];
    }
    if (buttonStates[3] == buttonStates[4] &&
        buttonStates[3] == buttonStates[5]) {
      is_over = true;
      winner = buttonStates[3];
    }
    if (buttonStates[6] == buttonStates[7] &&
        buttonStates[6] == buttonStates[8]) {
      is_over = true;
      winner = buttonStates[6];
    }
    if (buttonStates[0] == buttonStates[4] &&
        buttonStates[0] == buttonStates[8]) {
      is_over = true;
      winner = buttonStates[0];
    }
    if (buttonStates[2] == buttonStates[4] &&
        buttonStates[2] == buttonStates[6]) {
      is_over = true;
      winner = buttonStates[2];
    }
    bool containsZero = buttonStates.contains(0);
    if (is_over) {
      if ((choose_turn == 1 && winner == 2) ||
          (choose_turn == 2 && winner == 1)) {
        gameOver_against_bot = true;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Game Over'),
              content: const Text('Player won the game!'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        return true;
      } else if ((choose_turn == 1 && winner == 1) ||
          (choose_turn == 2 && winner == 2)) {
        gameOver_against_bot = true;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Game Over'),
              content: const Text('Bot won the game!'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        return true;
      }
    } else if (!containsZero) {
      gameOver_against_bot = true;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Game Over'),
            content: const Text('Draw!'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return true;
    }
    return false;
  }

  void botTurn(int turn) {
    int choice = generateRandomNumber();
    while (buttonStates[choice] != 0) {
      choice = generateRandomNumber();
    }
    setState(() {
      if (turn == 2)
        buttonStates[choice] = 2;
      else
        buttonStates[choice] = 1;
    });
  }

  int chooseTurn() {
    Random random = new Random();
    int number = random.nextInt(2) + 1;
    if (number == 1) botTurn(number);
    return number;
  }

  static int generateRandomNumber() {
    Random random = new Random();
    return random.nextInt(9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Against Bot',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (choose_turn == 1)
                    const Icon(
                      Icons.clear,
                      color: Colors.teal,
                      size: 40,
                    ),
                  if (choose_turn == 2)
                    const Icon(
                      Icons.circle_outlined,
                      color: Colors.teal,
                      size: 40,
                    ),
                  const Text(
                    "Player",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  if (choose_turn == 2)
                    const Icon(
                      Icons.clear,
                      color: Colors.teal,
                      size: 40,
                    ),
                  if (choose_turn == 1)
                    const Icon(
                      Icons.circle_outlined,
                      color: Colors.teal,
                      size: 40,
                    ),
                  const Text(
                    "Bot",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 50,
                  crossAxisSpacing: 50,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ElevatedButton(
                    onPressed: () {
                      if (gameOver_against_bot == true ||
                          buttonStates[index] != 0) return;
                      setState(() {
                        if (choose_turn == 2) buttonStates[index] = 1;
                        if (choose_turn == 1) buttonStates[index] = 2;
                      });
                      bool checkwin = checkWin();
                      if (!checkwin) botTurn(choose_turn);
                      checkWin();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.blue),
                      minimumSize:
                          WidgetStateProperty.all<Size>(const Size(100, 100)),
                    ),
                    child: buttonStates[index] == 0
                        ? const Text(' ')
                        : buttonStates[index] == 1
                            ? const Icon(
                                Icons.circle_outlined,
                                size: 30,
                              )
                            : const Icon(
                                Icons.clear,
                                size: 30,
                              ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Game {
  List<List<int>> twoDList = List.generate(3, (i) => List<int>.filled(3, 0));
  int playerTurn = 0;
  int movePlayer(List<int> button) {
    if (twoDList[button[0]][button[1]] == 0) {
      if (playerturn() % 2 == 0) {
        twoDList[button[0]][button[1]] = 2;
        return 2;
      } else {
        twoDList[button[0]][button[1]] = 1;
        return 1;
      }
    }
    return 3;
  }

  void checkWin(BuildContext context) {
    bool player1 = false;
    bool player2 = false;
    if (twoDList[0][0] == 1 && twoDList[1][1] == 1 && twoDList[2][2] == 1)
      player1 = true;
    if (twoDList[0][1] == 1 && twoDList[0][2] == 1 && twoDList[0][0] == 1)
      player1 = true;
    if (twoDList[1][0] == 1 && twoDList[2][0] == 1 && twoDList[0][0] == 1)
      player1 = true;
    if (twoDList[2][0] == 1 && twoDList[1][1] == 1 && twoDList[0][2] == 1)
      player1 = true;
    if (twoDList[0][2] == 1 && twoDList[1][2] == 1 && twoDList[2][2] == 1)
      player1 = true;
    if (twoDList[0][1] == 1 && twoDList[1][1] == 1 && twoDList[2][1] == 1)
      player1 = true;
    if (twoDList[1][0] == 1 && twoDList[1][1] == 1 && twoDList[1][2] == 1)
      player1 = true;
    if (twoDList[2][0] == 1 && twoDList[2][1] == 1 && twoDList[2][2] == 1)
      player1 = true;

    if (twoDList[0][0] == 2 && twoDList[1][1] == 2 && twoDList[2][2] == 2)
      player2 = true;
    if (twoDList[0][1] == 2 && twoDList[0][2] == 2 && twoDList[0][0] == 2)
      player2 = true;
    if (twoDList[1][0] == 2 && twoDList[2][0] == 2 && twoDList[0][0] == 2)
      player2 = true;
    if (twoDList[2][0] == 2 && twoDList[1][1] == 2 && twoDList[0][2] == 2)
      player2 = true;
    if (twoDList[0][2] == 2 && twoDList[1][2] == 2 && twoDList[2][2] == 2)
      player2 = true;
    if (twoDList[0][1] == 2 && twoDList[1][1] == 2 && twoDList[2][1] == 2)
      player2 = true;
    if (twoDList[1][0] == 2 && twoDList[1][1] == 2 && twoDList[1][2] == 2)
      player2 = true;
    if (twoDList[2][0] == 2 && twoDList[2][1] == 2 && twoDList[2][2] == 2)
      player2 = true;
    if (player1) {
      _VsHumanPageState.gameOver = true;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Game Over'),
            content: const Text('Player 1 won the game!'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    if (player2) {
      _VsHumanPageState.gameOver = true;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Game Over'),
            content: const Text('Player 2 won the game!'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    bool containsZero = twoDList.any((sublist) => sublist.contains(0));
    if (!containsZero) {
      _VsHumanPageState.gameOver = true;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Game Over'),
            content: const Text('Draw!'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  int playerturn() {
    return ++playerTurn;
  }
}
