import 'package:flutter/material.dart';

class Checkmark extends StatelessWidget {
  final Color? background;
  final Color? border;
  final double thickness;
  final bool check;

  const Checkmark(this.check, {this.background, this.border, this.thickness = 3.0, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: background ?? colorScheme.primary,
        border: Border.all(color: border ?? colorScheme.onPrimary, width: thickness),
        shape: BoxShape.circle,
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            (check) ? Icons.check_outlined : Icons.close_outlined,
            color: colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
