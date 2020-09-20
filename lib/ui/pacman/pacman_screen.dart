import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_brunch_challenge/ui/pacman/barrier_map.dart';

import 'component/path_square.dart';
import 'component/square.dart';

class PacManScreen extends StatefulWidget {
  @override
  _PacManScreenState createState() => _PacManScreenState();
}

class _PacManScreenState extends State<PacManScreen> {
  static int _numberInRow = 11;
  static int _numberInColumn = 17;
  int _numberOfSquares = _numberInRow * _numberInColumn;
  int ghost = (_numberInRow - 1) * 2; // 初始在右上角
  int player = _numberInRow * (_numberInColumn - 2) + 1;
  List _barriers = PacManMap().barriers;
  List<int> _foods = List();
  Timer _timer;
  String direction;
  int _score = 0;
  String gameStatus = 'stop';
  int frameDuration = 500;

  _playGame() {
    debugPrint('play game');
    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: frameDuration), (timer) {
      _move();
      // 一次更新這個 frame
      setState(() {});
    });
  }

  _stopTimer() {
    _timer?.cancel();
  }

  _damage() {
    _score--;
  }

  _eatFood() {
    _foods.remove(player);
    _score++;
  }

  _move() {
    debugPrint('move()');
    switch (direction) {
      case "up":
        _moveUp();
        break;
      case "down":
        _moveDown();
        break;
      case "left":
        _moveLeft();
        break;
      case "right":
        _moveRight();
        break;
    }
    // 動完後判斷有沒有被抓到
    if (ghost == player) {
      _damage();
    }
    // 動完就判斷是否有東西吃
    if (_foods.contains(player)) {
      // 若 食物列表 包含 player 上個 frame 移動後的位置，則代表，可以吃到！！
      _eatFood();
    }
  }

  bool _canGo(int index) => _barriers.contains(index);

  _moveUp() {
    if (_canGo(player - _numberInRow)) {
      debugPrint('撞牆，不動');
    } else {
      player -= _numberInRow;
    }
  }

  _moveDown() {
    if (_canGo(player + _numberInRow)) {
      debugPrint('撞牆，不動');
    } else {
      player += _numberInRow;
    }
  }

  _moveLeft() {
    if (_canGo(player - 1)) {
      debugPrint('撞牆，不動');
    } else {
      player--;
    }
  }

  _moveRight() {
    if (_canGo(player + 1)) {
      debugPrint('撞牆，不動');
    } else {
      player++;
    }
  }

  Widget _playerRolw() {
    double angle = 0;
    switch (direction) {
      case "up":
        angle = pi / 2 * 3;
        break;
      case "down":
        angle = pi / 2;
        break;
      case "left":
        angle = pi;
        break;
      case "right":
        angle = pi * 2;
        break;
    }
    return Transform.rotate(
      angle: angle,
      child: Image.asset("images/pacman.png"),
    );
  }

  Widget _ghostRole() {
    return Image.asset("images/ghost.png");
  }

  Widget _gameView() {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onVerticalDragUpdate: (DragUpdateDetails details) {
        if (details.delta.dy < 0) {
          direction = "up";
        } else {
          direction = "down";
        }
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        if (details.delta.dx < 0) {
          direction = "left";
        } else {
          direction = "right";
        }
      },
      child: Container(
        child: GridView.builder(
          itemCount: _numberOfSquares,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _numberInRow,
          ),
          itemBuilder: (BuildContext context, int index) {
            if (index == ghost) {
              return _ghostRole();
            }
            if (index == player) {
              return _playerRolw();
            }
//            final childForDebug = Text('$index');
            final childForDebug = null;
            if (_barriers.contains(index)) {
              return Square(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.cyan,
                child: childForDebug,
              );
            }
            if (_foods.contains(index)) {
              return PathSquare(
                backgroundColor: Colors.black,
                foregroundColor: Colors.yellow,
                child: childForDebug,
              );
            }
            return PathSquare(
              backgroundColor: Colors.black,
              foregroundColor: Colors.black,
              child: childForDebug,
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _numberOfSquares; i++) {
      if (_barriers.contains(i)) {
        // 是路障，不會有食物
      } else {
        _foods.add(i);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    debugPrint('dispose()');
  }

  Widget _gameViewByStatus() {
    switch (gameStatus) {
      case 'playing':
        return _gameView();
      case 'pause':
        return Stack(children: [
          _gameView(),
          Positioned.fill(
            child: Container(
              color: Colors.white24,
            ),
          ),
          Center(
            child: _playButton(),
          ),
        ]);
    }
    // 預設 stop
    return Stack(children: [
      _gameView(),
      Positioned.fill(
        child: Container(
          color: Colors.white54,
        ),
      ),
      Center(
        child: _playButton(),
      ),
    ]);
  }

  Widget _gameStatusButton() {
    switch (gameStatus) {
      case 'playing':
        return _pauseButton();
      case 'pause':
        return _playButton();
    }
    // 其他都是 stop，要點了開始玩
    return _playButton();
  }

  _playButton() {
    return FlatButton(
      onPressed: _clickPlay,
      child: Text(
        'P L A Y',
        style: TextStyle(color: Colors.white, fontSize: 36),
      ),
    );
  }

  _pauseButton() {
    return FlatButton(
      onPressed: _clickPause,
      child: Text(
        'P A U S E',
        style: TextStyle(color: Colors.white, fontSize: 36),
      ),
    );
  }

  _clickPlay() {
    debugPrint('_clickPlay');
    gameStatus = "playing";
    _playGame();
  }

  _clickPause() {
    debugPrint('_clickPause');
    gameStatus = "pause";
    _stopTimer();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ///    小精靈圖檔
    ///    Image.asset("images/pacman.png")
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: _gameViewByStatus(),
          ),
          Expanded(
            child: Container(
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Score: $_score',
                    style: TextStyle(color: Colors.white, fontSize: 36),
                  ),
                  _gameStatusButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
