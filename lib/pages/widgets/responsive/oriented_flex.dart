import 'package:flutter/material.dart';

import 'package:fabrics/pages/widgets/responsive/axis_extension.dart';

class OrientedFlex extends StatelessWidget {
  final Axis landscapeOrientation;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final Clip clipBehavior;
  final List<Widget> children;

  const OrientedFlex({
    this.landscapeOrientation = Axis.horizontal,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.clipBehavior = Clip.none,
    this.children = const <Widget>[],
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Flex(
        direction: (MediaQuery.of(context).orientation == Orientation.landscape) ? landscapeOrientation : landscapeOrientation.opposite,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        textBaseline: textBaseline,
        clipBehavior: clipBehavior,
        children: children,
      );
}
