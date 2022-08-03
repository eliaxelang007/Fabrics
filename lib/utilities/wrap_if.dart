import 'package:flutter/material.dart';

class WrapIf extends StatelessWidget {
  final Widget Function({required Widget child}) wrapper;
  final Widget child;
  final bool condition;

  const WrapIf({required this.condition, required this.wrapper, required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => (condition) ? wrapper(child: child) : child;
}
