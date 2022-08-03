import 'package:flutter/material.dart';

class Fit extends StatelessWidget {
  final Widget child;
  final BoxFit fit;
  final double width;
  final double height;

  const Fit({required this.child, this.fit = BoxFit.contain, required this.width, required this.height, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        width: width,
        height: height,
        child: FittedBox(
          fit: fit,
          child: child,
        ),
      );
}
