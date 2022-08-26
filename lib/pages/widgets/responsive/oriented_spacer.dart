import 'package:fabrics/pages/widgets/responsive/axis_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrientedSpacer extends StatelessWidget {
  final Axis landscapeOrientation;

  final double landscapeLength;
  final double portraitLength;

  const OrientedSpacer(this.landscapeLength, {this.portraitLength = -1, this.landscapeOrientation = Axis.horizontal, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final landscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return ((landscape) ? landscapeOrientation : landscapeOrientation.opposite)
        .spacer((landscape) ? landscapeLength : ((portraitLength < 0) ? landscapeLength : portraitLength));
  }
}

extension on Axis {
  SizedBox Function(double) get spacer =>
      (this == Axis.horizontal) ? (double length) => SizedBox(width: length.w) : (double length) => SizedBox(height: length.h);
}
