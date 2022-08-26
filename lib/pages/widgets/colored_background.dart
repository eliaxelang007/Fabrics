import 'package:flutter/material.dart';

class ColoredBackground extends StatelessWidget {
  final Color color;
  final Widget child;

  const ColoredBackground({required this.color, required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox.expand(
        child: ColoredBox(
          color: color,
          child: child,
        ),
      );
}
