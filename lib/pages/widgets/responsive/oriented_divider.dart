import 'package:fabrics/pages/widgets/responsive/axis_extension.dart';
import 'package:flutter/material.dart';

class OrientedDivider extends StatelessWidget {
  final Axis landscapeOrientation;

  final Color? color;
  final double? endIndent;
  final double? indent;
  final double? thickness;

  const OrientedDivider({this.landscapeOrientation = Axis.vertical, this.color, this.endIndent, this.indent, this.thickness, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) =>
      ((MediaQuery.of(context).orientation == Orientation.landscape) ? landscapeOrientation : landscapeOrientation.opposite).divider(
        color: color,
        endIndent: endIndent,
        indent: indent,
        thickness: thickness,
      );
}

extension on Axis {
  StatelessWidget Function({Color? color, double? endIndent, double? indent, Key? key, double? thickness}) get divider =>
      (this == Axis.horizontal) ? Divider.new : VerticalDivider.new;
}
