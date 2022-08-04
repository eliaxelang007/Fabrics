import 'package:flutter/material.dart';

import 'package:handy/handy.dart';

class FlexPadded extends StatelessWidget {
  final int top;
  final int right;
  final int bottom;
  final int left;

  final int childHorizontal;
  final int childVertical;

  final Widget child;

  const FlexPadded({
    required this.child,
    this.top = 1,
    this.right = 1,
    this.bottom = 1,
    this.left = 1,
    this.childHorizontal = 1,
    this.childVertical = 1,
    Key? key,
  }) : super(key: key);

  const FlexPadded.symmetrical({
    required this.child,
    int vertical = 1,
    int horizontal = 1,
    this.childHorizontal = 1,
    this.childVertical = 1,
    Key? key,
  })  : top = vertical,
        bottom = vertical,
        left = horizontal,
        right = horizontal,
        super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        children: <Widget>[
          if (left >= 1) Spacer(flex: right),
          Expanded(
            flex: childHorizontal,
            child: Column(
              children: <Widget>[
                if (top >= 1) Spacer(flex: top),
                Expanded(
                  flex: childVertical,
                  child: child,
                ),
                if (bottom >= 1) Spacer(flex: bottom)
              ],
            ),
          ),
          if (right >= 1) Spacer(flex: right)
        ],
      );
}
