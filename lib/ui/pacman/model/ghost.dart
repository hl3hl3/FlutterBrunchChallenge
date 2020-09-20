import 'dart:math';

/// return true if index will not hit the barrier
typedef CanGo = bool Function(int index);

/// return position
typedef NextPosition = int Function(int index);

class Ghost {
  int position;
  final CanGo canGo;
  final NextPosition nextUp;
  final NextPosition nextDown;
  final NextPosition nextLeft;
  final NextPosition nextRight;

  Ghost({
    this.nextUp,
    this.nextDown,
    this.nextLeft,
    this.nextRight,
    this.canGo,
    this.position,
  });

  bool isHit(int position) => this.position == position;

  List _ghostNext = List();

  _addToGhostNextIfValid(int position) {
    if (canGo(position)) {
      _ghostNext.add(position);
    }
  }

  move() {
    _ghostNext.clear();
    _addToGhostNextIfValid(nextUp(position));
    _addToGhostNextIfValid(nextDown(position));
    _addToGhostNextIfValid(nextLeft(position));
    _addToGhostNextIfValid(nextRight(position));
    position = _ghostNext[Random.secure().nextInt(_ghostNext.length)];
  }
}
