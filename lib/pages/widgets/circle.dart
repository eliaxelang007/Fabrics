import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  final BoxDecoration decoration;
  final Widget child;

  const Circle({required this.child, this.decoration = const BoxDecoration(), Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: decoration.copyWith(shape: BoxShape.circle),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Padding(padding: const EdgeInsets.all(4.0), child: child),
        ),
      );
}
