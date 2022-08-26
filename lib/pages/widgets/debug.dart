import 'package:flutter/material.dart';

class Debug extends StatelessWidget {
  final Widget child;

  final Color borderColor;
  final double borderWidth;

  const Debug({required this.child, this.borderColor = Colors.black, this.borderWidth = 10, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: borderWidth),
        ),
        child: child,
      );
}
