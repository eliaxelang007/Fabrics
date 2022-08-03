import 'package:flutter/material.dart';

class Debug extends StatelessWidget {
  final Widget child;
  final Color color;

  const Debug({required this.child, this.color = Colors.black, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 10),
        ),
        child: child,
      );
}
