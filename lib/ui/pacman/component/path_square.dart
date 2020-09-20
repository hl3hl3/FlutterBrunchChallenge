import 'package:flutter/material.dart';

class PathSquare extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final Color foregroundColor;

  PathSquare({
    this.child,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: backgroundColor,
          padding: EdgeInsets.all(14),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              color: foregroundColor,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
