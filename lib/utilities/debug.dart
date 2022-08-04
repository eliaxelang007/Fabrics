import 'package:flutter/material.dart';

class Debug extends StatelessWidget {
  final Widget child;
  final Color color;
  final double width;

  const Debug({required this.child, this.color = Colors.black, this.width = 10, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: color, width: width),
        ),
        child: child,
      );
}
