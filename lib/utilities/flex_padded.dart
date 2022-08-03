import 'package:flutter/material.dart';
import 'package:handy/handy.dart';

class FlexPadded extends StatelessWidget {
  final int horizontalPadding;
  final int verticalPadding;

  final int horizontal;
  final int vertical;

  final Widget child;

  const FlexPadded({
    required this.child,
    this.horizontalPadding = 1,
    this.verticalPadding = 1,
    this.horizontal = 1,
    this.vertical = 1,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        children: <Widget>[
          Expanded(
            flex: horizontal,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: vertical,
                  child: child,
                ),
              ].inBetween((index) => Spacer(flex: verticalPadding), outer: (verticalPadding >= 1) ? true : false).toList(),
            ),
          )
        ].inBetween((index) => Spacer(flex: horizontalPadding), outer: (horizontalPadding >= 1) ? true : false).toList(),
      );
}
