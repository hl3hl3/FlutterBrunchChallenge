import 'package:flutter/material.dart';

class Square extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final Color foregroundColor;

  Square({
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
          padding: EdgeInsets.all(2),
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
