import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class PlayerRole extends StatefulWidget {

  final String direction;

  final String gameStatus;

  PlayerRole({this.direction, this.gameStatus});

  @override
  _PlayerRoleState createState() => _PlayerRoleState();
}

class _PlayerRoleState extends State<PlayerRole> {
  final List images = [
    "images/pacman.png",
    "images/pacman_.png",
    "images/pacman__.png",
    "images/pacman_.png",
  ];

  int showingImage = 0;

  Timer timer;

  _action() {
    timer?.cancel();
    timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (showingImage < images.length - 1) {
        showingImage ++;
      } else {
        showingImage = 0;
      }
      setState((){});
    });
  }

  _freeze() {
    timer?.cancel();
  }

  @override
  void initState() {
    super.initState();
    _action();
  }

  @override
  void dispose() {
    super.dispose();
    _freeze();
  }

  @override
  Widget build(BuildContext context) {
    double angle = 0;
    switch (widget.direction) {
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
      child: Image.asset(images[showingImage]),
    );
  }
}
